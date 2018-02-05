import Foundation

protocol MessagesServiceObserver: class {

    func receive(message: Message, from service: MessagesService)

}

final class MessagesStorage {

    private var storage: [UserID:[Message]] = [:]

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

    func subcribe(_ observer: MessagesServiceObserver, for user: User? = nil) {
        let userID: UserID = user?.id ?? broadcastID

        if observers[userID] == nil {
            observers[userID] = []
        }

        if let observersForUserID = observers[userID], !observersForUserID.contains(where: { $0 === observer }) {
            observers[userID]?.append(observer)
        }
    }

    func unsubscribe(_ observer: MessagesServiceObserver, from user: User? = nil) {
        let userID: UserID = user?.id ?? broadcastID

        if let index = observers[userID]?.index(where: { $0 === observer }) {
            observers[userID]?.remove(at: index)
        }
    }

    private func notify(with message: Message) {
        if let observers = observers[broadcastID] {
            observers.forEach { $0.receive(message: message, from: self) }
        }

        if let observers = observers[message.senderId] {
            observers.forEach { $0.receive(message: message, from: self) }
        }
    }

    // MARK: - Interaction

    func send(_ message: Message, to userID: UserID, completion: @escaping (ClientConstants.SendRequest) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let `self` = self else { return }
            self.client.send(message: message, to: userID, completion: completion)
            self.storage.add(message, userID: userID)
            self.notify(with: message)
        }
    }

    func startListeningToServer() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
//            self?.fetchAllMessages()
        }
    }

    func fetchConversations(completion: @escaping ([Conversation]?) -> Void) {
        client.getConversations { request in
            switch request {
            case let .fail(response):
                completion(nil)

            case let .success(conversations):
                completion(conversations)
            }
        }
    }

    func fetchAllMessages(completion: @escaping ([Message]?) -> Void) {
//        client.receive(.all, from: nil) { request in
//            switch request {
//            case let .fail(response):
//                completion(nil)
//
//            case let .success(messages):
//                completion(messages)
//            }
//        }
    }

}
