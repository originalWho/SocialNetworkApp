import Foundation

protocol MessagesServiceObserver {

    var observerID: Int { get set }
    func receive(message: Message, from service: MessagesService)

}

struct MessagesStorage {
    private var messages: [Int:[Message]]

    init() {
        messages = [Int:[Message]]()
    }

    subscript(userID: Int) -> [Message] {
        get {
            if let messagesFromUserID = messages[userID] {
                return messagesFromUserID
            }
            else {
                return []
            }

        }
        set(messagesForUserID) {
            messages[userID] = messagesForUserID
        }
    }
}

final class MessagesService {

    // MARK: - Internal static properties

    static let `default`: MessagesService = MessagesService(client: SocialNetworkClient.default)

    // MARK: - Private properties

    private let client: Client
    private var storage: MessagesStorage = MessagesStorage()
    private var observers = [MessagesServiceObserver]()

    init(client: Client) {
        self.client = client
    }

    func subscribe(observer: MessagesServiceObserver) {
        if !observers.contains(where: { $0.observerID == observer.observerID }) {
            observers.append(observer)
        }
    }

    func unsubscribe(observer: MessagesServiceObserver) {
        if let index = observers.index(where: { $0.observerID == observer.observerID }) {
            observers.remove(at: index)
        }
    }

    private func notify(with message: Message) {
        for observer in observers {
            observer.receive(message: message, from: self)
        }
    }

    private func observe() {
        
    }

}
