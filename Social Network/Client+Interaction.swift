import Alamofire

// MARK: - Messages

extension SocialNetworkClient {

    enum SendRequest {
        case fail(ServerResponse)
        case success
    }

    func send(message: Message, to userId: Int, completion: @escaping (SendRequest) -> Void) {
        let method = String(format: Methods.Conversation.SendMessageTo, userId)
        let sendMessageToURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: sendMessageToURL, method: .post) { response in
            print(response)
        }
    }

    func send(status: Message.Status, for messageID: String, to userId: String, completion: @escaping (SendRequest) -> Void) {

    }

    enum ReceiveMode {
        case latest(Int, Int)
        case all
    }

    enum MessagesRequest {
        case fail(ServerResponse)
        case success([Message])
    }

    func receive(_ mode: ReceiveMode, from userId: Int? = nil, completion: @escaping (MessagesRequest) -> Void) {
        typealias Key = Methods.Conversation.Key

        var parameters = [String:Any]()
        parameters[Key.ID] = userId

        switch mode {
        case .latest(let offset, let count):
            parameters[Key.Offset] = offset
            parameters[Key.Count] = count

        case .all:
            break
        }

        let messagesFromURL = url(from: parameters, path: Constants.APIPath, method: Methods.Conversation.Messages)
        print(messagesFromURL)
        alamofireRequest(url: messagesFromURL) { response in
            print(response)
            guard let json = response.result.value as? [String:Any] else {
                completion(.fail(.unknownError))
                return
            }

            print(json)
        }
    }
    
}

// MARK: - Users

extension SocialNetworkClient {

    enum ActionRequest {
        case fail(ServerResponse)
        case success
    }

    func getFriends(of userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Friends, userId)
        let friendsURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: friendsURL) { response in
            print(response)
        }
    }

    func getSubscribers(of userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Subscribers, userId)
        let subscribersURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: subscribersURL) { response in
            print(response)
        }
    }

    func getSubscribtions(of userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Subscriptions, userId)
        let subscribtionsURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: subscribtionsURL) { response in
            print(response)
        }
    }

    func getBlacklist(of userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Blacklist, userId)
        let blacklistURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: blacklistURL) { response in
            print(response)
        }
    }

    func friend(_ userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Add, userId)
        let friendURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: friendURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

    func unfriend(_ userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Remove, userId)
        let unfriendURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: unfriendURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

    func block(_ userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Block, userId)
        let blockURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: blockURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

    func unblock(_ userId: Int, completion: @escaping (ActionRequest) -> Void) {
        let method = String(format: Methods.Profile.Unblock, userId)
        let unblockURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: unblockURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

}
