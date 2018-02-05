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

    func receive(from userID: UserID,
                 completion: @escaping (ClientConstants.MessagesRequest) -> Void) {
        receive(from: userID, offset: 0, count: 50, completion: completion)
    }

    func receive(from userID: UserID, offset: Int, count: Int, completion: @escaping (ClientConstants.MessagesRequest) -> Void) {
        typealias Key = ClientConstants.Methods.Conversation.Key

        var parameters = [String:Any]()
        parameters[Key.id] = userID
        parameters[Key.count] = count
        parameters[Key.offset] = offset

        let messagesFromURL = url(from: parameters, path: ClientConstants.Constants.APIPath,
                                  method: ClientConstants.Methods.Conversation.message)

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

    func getConversations(completion: @escaping (ClientConstants.ConversationsRequest) -> Void) {
        let conversationsURL = url(from: nil, path: ClientConstants.Constants.APIPath,
                                   method: ClientConstants.Methods.Conversation.conversations)
        alamofireRequest(url: conversationsURL) { response in
            print(response)
            guard let conversationsJSON = response.result.value as? [String:[String:Any]] else {
                completion(.fail(.unknownError))
                return
            }
            print(conversationsJSON)

            var conversations = [Conversation]()
            for (userID, message) in conversationsJSON {
                guard let userID = UInt64(userID), let message = Message(from: message) else { continue }
                let conversation = Conversation(userID: userID, message: message)
                conversations.append(conversation)
            }

            completion(.success(conversations))
        }
    }
    
}

// MARK: - Users

extension SocialNetworkClient {

    func getFriends(of userId: UserID, completion: @escaping (ClientConstants.UserListRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.friends, userId)
        let friendsURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: friendsURL) { response in
            print(response)
        }
    }

    func getSubscribers(of userId: UserID, completion: @escaping (ClientConstants.UserListRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.subscribers, userId)
        let subscribersURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: subscribersURL) { response in
            guard let dicts = response.result.value as? [[String:Any]] else {
                completion(.fail(.unknownError))
                return
            }

            var subscribers = [User]()
            dicts.forEach { subscribers.append(User(from: $0)) }
            subscribers.forEach { UserManager.shared.add(entry: $0) }
            completion(.success(subscribers))
        }
    }

    func getSubscribtions(of userId: UserID, completion: @escaping (ClientConstants.UserListRequest) -> Void) {
        let method = String(format: ClientConstants.Methods.Profile.subscriptions, userId)
        let subscribtionsURL = url(from: nil, path: ClientConstants.Constants.APIPath, method: method)

        alamofireRequest(url: subscribtionsURL) { response in
            guard let dicts = response.result.value as? [[String:Any]] else {
                completion(.fail(.unknownError))
                return
            }

            var subscribtions = [User]()
            dicts.forEach { subscribtions.append(User(from: $0)) }
            subscribtions.forEach { UserManager.shared.add(entry: $0) }
            completion(.success(subscribtions))
        }
    }

    func getBlacklist(of userId: UserID, completion: @escaping (ClientConstants.UserListRequest) -> Void) {
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
