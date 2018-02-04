import Foundation

final class UserManager: BaseStorageManager<User> {

    static let shared = UserManager(client: SocialNetworkClient.default)

    private var client: Client?

    private override init() {
        super.init()
    }

    init(client: Client) {
        self.client = client
    }

    override func subscribe(observer: StorageManagerObserver) {
        assertionFailure()
    }

    override func unsubscribe(observer: StorageManagerObserver) {
        assertionFailure()
    }

    func getUser(with userID: UserID?, completion: @escaping (User?) -> Void) {
        guard let index = storage.index(where: { $0.id == userID }) else {
            fetchUser(with: userID, completion: completion)
            return
        }

        completion(storage[index])
    }

    private func fetchUser(with userID: UserID?, completion: @escaping (User?) -> Void) {
        client?.getProfile(userID) { [weak self] request in
            switch request {
            case let .fail(response):
                completion(nil)

            case let .success(user):
                self?.add(entry: user)
                completion(user)
            }
        }
    }

}
