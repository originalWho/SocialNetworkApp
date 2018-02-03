import Alamofire

// MARK: - Messages

extension SocialNetworkClient {

    func send(message: Message, to userId: UserID, completion: @escaping (ClientConstants.SendRequest) -> Void) {
        let method = ClientConstants.Methods.Conversation.message
        let queryParameters: [String: Any] = [ClientConstants.Methods.Conversation.Key.id: userId]
        let sendMessageToURL = url(from: queryParameters, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: sendMessageToURL, method: .post, parameters: message.json) { response in
            print(response)
        }
    }

    func receive(_ mode: ClientConstants.ReceiveMode, from userId: UserID? = nil,
                 completion: @escaping (ClientConstants.MessagesRequest) -> Void) {
        typealias Key = ClientConstants.Methods.Conversation.Key

        var parameters = [String:Any]()

        switch mode {
        case .latest(let offset, let count):
            parameters[Key.id] = userId
            parameters[Key.offset] = offset
            parameters[Key.count] = count

        case .all:
            parameters[Key.id] = UInt64(249)
            parameters[Key.offset] = 0
            parameters[Key.count] = 20
        }

        let messagesFromURL = url(from: parameters, path: ClientConstants.Constants.APIPath,
                                  method: ClientConstants.Methods.Conversation.messages)
        print(messagesFromURL)
        alamofireRequest(url: messagesFromURL) { response in
            guard let jsonMessages = response.result.value as? [[String:Any]] else {
                completion(.fail(.unknownError))
                return
            }

            var messages = [Message]()
            for jsonMessage in jsonMessages {
                guard let message = Message(from: jsonMessage) else {
                    continue
                }

                messages.append(message)
            }

            completion(.success(messages))
        }
    }
    
}

// MARK: - Users

extension SocialNetworkClient {

    func getFriends(of userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.friends, userId)
        let friendsURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: friendsURL) { response in
            print(response)
        }
    }

    func getSubscribers(of userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.subscribers, userId)
        let subscribersURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: subscribersURL) { response in
            print(response)
        }
    }

    func getSubscribtions(of userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.subscriptions, userId)
        let subscribtionsURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: subscribtionsURL) { response in
            print(response)
        }
    }

    func getBlacklist(of userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.blacklist, userId)
        let blacklistURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: blacklistURL) { response in
            print(response)
        }
    }

    func friend(_ userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.add, userId)
        let friendURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: friendURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

    func unfriend(_ userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.remove, userId)
        let unfriendURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: unfriendURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

    func block(_ userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.block, userId)
        let blockURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: blockURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

    func unblock(_ userId: UserID, completion: @escaping (ClientConstants.ActionRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.unblock, userId)
        let unblockURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: unblockURL, method: .post) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.fail(.unknownError))
                return
            }

            completion(.success)
        }
    }

}
