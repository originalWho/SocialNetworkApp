import Alamofire

// MARK: - Messages

extension SocialNetworkClient {

    enum ReceiveMode {
        case latest(Int, Int)
        case all
    }

    func send(message: Message, to userID: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Conversation.SendMessageTo, userID)
        let sendMessageToURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: sendMessageToURL, method: .post) { response in
            print(response)
        }
    }

    func send(status: Message.Status, for messageID: String, to: String, completion: @escaping (ServerResponse?) -> Void) {

    }

    func receive(completion: @escaping (ServerResponse?) -> Void) {
        let messagesURL = url(from: nil, path: Constants.APIPath, method: Methods.Conversation.Messages)

        alamofireRequest(url: messagesURL) { response in
            print(response)
        }
    }

    func receive(with mode: ReceiveMode, from user: String, completion: @escaping (ServerResponse?) -> Void) {
        typealias Key = Methods.Conversation.Key

        var parameters = [String:Any]()
        parameters[Key.ID] = user

        switch mode {
        case let .latest(offset, count):
            parameters[Key.Offset] = offset
            parameters[Key.Count] = count

        case .all:
            break
        }

        let messagesFromURL = url(from: parameters, path: Constants.APIPath, method: Methods.Conversation.MessagesFrom)

        alamofireRequest(url: messagesFromURL) { response in
            print(response)
        }
    }
    
}

// MARK: - Users

extension SocialNetworkClient {

    func getFriends(of userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Friends, userId)
        let friendsURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: friendsURL) { response in
            print(response)
        }
    }

    func getSubscribers(of userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Subscribers, userId)
        let subscribersURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: subscribersURL) { response in
            print(response)
        }
    }

    func getSubscribtions(of userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Subscriptions, userId)
        let subscribtionsURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: subscribtionsURL) { response in
            print(response)
        }
    }

    func getBlacklist(of userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Blacklist, userId)
        let blacklistURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: blacklistURL) { response in
            print(response)
        }
    }

    func friend(_ userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Add, userId)
        let friendURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: friendURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.unknownError)
                return
            }

            completion(response)
        }
    }

    func unfriend(_ userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Remove, userId)
        let unfriendURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: unfriendURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.unknownError)
                return
            }

            completion(response)
        }
    }

    func block(_ userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Block, userId)
        let blockURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: blockURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.unknownError)
                return
            }

            completion(response)
        }
    }

    func unblock(_ userId: String, completion: @escaping (ServerResponse?) -> Void) {
        let method = String(format: Methods.Profile.Unblock, userId)
        let unblockURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: unblockURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.unknownError)
                return
            }

            completion(response)
        }
    }

}
