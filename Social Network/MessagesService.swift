import Foundation

protocol MessagesServiceObserver: class {

    func onUpdate(service: MessagesService)
    func onUpdate(from userID: UserID, service: MessagesService)

}

final class MessagesStorage {

    private var conversationsStorage: [UserID:[MessageProtocol]] = [:]

    var userIDs: Set<UserID> {
        return Set(conversationsStorage.keys)
    }

    fileprivate var messageIDs: Set<MessageID> {
        var messageIDs = Set<MessageID>()
        for conversation in conversationsStorage.values {
            guard let messageID = conversation.last?.id else { continue }
            messageIDs.insert(messageID)
        }
        return messageIDs
    }

    var conversations: [Conversation] {
        var conversations = [Conversation]()
        for (userID, messages) in conversationsStorage {
            guard let message = messages.last else {
                continue
            }

            let conversation = Conversation(userID: userID, message: message)
            conversations.append(conversation)
        }
        return conversations.sorted(by: { $0.message.date > $1.message.date })
    }

    subscript(userID: UserID) -> [MessageProtocol] {
        get {
            if let messages = conversationsStorage[userID] {
                return messages
            }
            else {
                return []
            }
        }

        set {
            conversationsStorage[userID] = newValue
        }
    }

    fileprivate func add(_ message: MessageProtocol, userID: UserID) {
        if conversationsStorage[userID] == nil {
            conversationsStorage[userID] = []
        }

        conversationsStorage[userID]?.append(message)
    }

    fileprivate func remove(_ message: MessageProtocol, userID: UserID) {
        if let index = conversationsStorage[userID]?.index(where: { $0.id == message.id }) {
            conversationsStorage[userID]?.remove(at: index)
        }
    }

}

final class MessagesService {

    // MARK: - Internal static properties

    static let `default`: MessagesService = MessagesService(client: SocialNetworkClient.default)

    // MARK: - Private properties

    let storage: MessagesStorage = MessagesStorage()

    private let client: Client
    private var observers = [UserID:[MessagesServiceObserver]]()
    private let broadcastID: UserID = .max

    init(client: Client) {
        self.client = client
    }

    // MARK: - Subscription

    func subcribe(_ observer: MessagesServiceObserver, for userID: UserID? = nil) {
        let userID: UserID = userID ?? broadcastID

        if observers[userID] == nil {
            observers[userID] = []
        }

        if let observersForUserID = observers[userID], !observersForUserID.contains(where: { $0 === observer }) {
            observers[userID]?.append(observer)
        }
    }

    func unsubscribe(_ observer: MessagesServiceObserver, from userID: UserID? = nil) {
        let userID: UserID = userID ?? broadcastID

        if let index = observers[userID]?.index(where: { $0 === observer }) {
            observers[userID]?.remove(at: index)
        }
    }

    private func notify(for userID: UserID) {
        if let observers = observers[broadcastID] {
            observers.forEach { $0.onUpdate(service: self) }
        }

        if let observers = observers[userID] {
            observers.forEach { $0.onUpdate(from: userID, service: self) }
        }
    }

    // MARK: - Interaction

    func send(_ message: MessageProtocol, to userID: UserID, completion: @escaping (ClientConstants.SendRequest) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let `self` = self else { return }
            self.client.send(message: message, to: userID, completion: completion)
            self.storage.add(message, userID: userID)
        }
    }

    func startListeningToServer() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            DispatchQueue.global(qos: .utility).async { [weak self] in
                self?.fetchConversations() { conversations in
                    guard let conversations = conversations, let `self` = self else { return }

                    let newValue = Set(conversations.flatMap { $0.message.id })
                    let oldValue = self.storage.messageIDs

                    if newValue != oldValue {
                        let userIDs = self.storage.userIDs.union(conversations.flatMap { $0.userID })
                        for userID in userIDs {
                            self.updateMessages(for: userID)
                        }
                    }
                }
            }
        }
    }

    private func fetchConversations(completion: @escaping ([Conversation]?) -> Void) {
        client.getConversations { request in
            switch request {
            case let .fail(response):
                completion(nil)

            case let .success(conversations):
                completion(conversations)
            }
        }
    }

    private func updateMessages(for userID: UserID) {
        client.receive(from: userID) { [weak self] request in
            switch request {
            case let .fail(response):
                return

            case let .success(messages):
                self?.storage[userID] = messages
                self?.notify(for: userID)
            }
        }
    }

}
