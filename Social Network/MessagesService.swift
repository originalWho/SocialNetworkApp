import Foundation

protocol MessagesServiceObserver: class {

    func onUpdate(service: MessagesService)
    func onUpdate(from userID: UserID, service: MessagesService)

}

final class MessagesStorage {

    private var storage: [UserID:[Message]] = [:]

    var userIDs: Set<UserID> {
        return Set(storage.keys)
    }

    var messages: Set<Message> {
        var messages = Set<Message>()
        for conversation in storage.values {
            guard let message = conversation.last else { continue }
            messages.insert(message)
        }
        return messages
    }

    var conversations: [Conversation] {
        var conversations = [Conversation]()
        for (userID, messages) in storage {
            guard let message = messages.last else {
                continue
            }

            let conversation = Conversation(userID: userID, message: message)
            conversations.append(conversation)
        }
        return conversations.sorted(by: { $0.message.date > $1.message.date })
    }

    subscript(userID: UserID) -> [Message] {
        get {
            if let messages = storage[userID] {
                return messages
            }
            else {
                return []
            }
        }

        set {
            storage[userID] = newValue
        }
    }

    fileprivate func add(_ message: Message, userID: UserID) {
        if storage[userID] == nil {
            storage[userID] = []
        }

        storage[userID]?.append(message)
    }

    fileprivate func remove(_ message: Message, userID: UserID) {
        if let index = storage[userID]?.index(where: { $0.id == message.id }) {
            storage[userID]?.remove(at: index)
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

    func send(_ message: Message, to userID: UserID, completion: @escaping (ClientConstants.SendRequest) -> Void) {
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
                    let oldValue = Set(self.storage.messages.flatMap { $0.id })

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
