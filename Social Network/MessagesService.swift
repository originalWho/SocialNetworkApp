import Foundation

protocol MessagesServiceObserver: class {

    func receive(message: Message, from service: MessagesService)

}

final class MessagesStorage {

    private var storage: [User:[Message]] = [:]

    var conversations: [Conversation] {
        var conversations = [Conversation]()
        for (user, messages) in storage {
            guard let message = messages.last else {
                continue
            }

            let conversation = Conversation(user: user, message: message)
            conversations.append(conversation)
        }
        return conversations.sorted(by: { $0.message.date > $1.message.date })
    }

    subscript(user: User) -> [Message] {
        get {
            if let messages = storage[user] {
                return messages
            }
            else {
                return []
            }
        }

        set {
            storage[user] = newValue
        }
    }

    fileprivate func add(_ message: Message, user: User) {
        if storage[user] == nil {
            storage[user] = []
        }

        storage[user]?.append(message)
    }

    fileprivate func remove(_ message: Message, user: User) {
        if let index = storage[user]?.index(where: { $0.id == message.id }) {
            storage[user]?.remove(at: index)
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

    func send(_ message: Message, to user: User, completion: @escaping (ClientConstants.SendRequest) -> Void) {
        guard let userID = user.id else {
            return
        }

        client.send(message: message, to: userID, completion: completion)
        storage.add(message, user: user)
        notify(with: message)
    }

    func startListeningToServer() {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
//            self?.fetchAllMessages()
        }
    }

    func fetchAllMessages(completion: @escaping ([Message]?) -> Void) {
        client.receive(.all, from: nil) { request in
            switch request {
            case let .fail(response):
                completion(nil)

            case let .success(messages):
                completion(messages)
            }
        }
    }

}
