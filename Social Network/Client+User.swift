import Alamofire

// MARK: - Register

extension SocialNetworkClient {
    
    func register(parameters: [String:Any], completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void) {
        let registerURL = url(from: nil, path: ClientConstants.Constants.APIPath,
                              method: ClientConstants.Methods.register)
        
        alamofireRequest(url: registerURL, method: .post, parameters: parameters) { [weak self] response in
            guard let this = self else {
                completion(nil)
                return
            }

            print(response.debugDescription)
            let response = this.serverResponse(from: response.data)
            guard response == .success else {
                completion(response)
                return
            }

            var parameters = parameters
            parameters[ClientConstants.OAuth.ParameterKeys.GrantType] = ClientConstants.OAuth.GrantType.password
            this.authenticate(parameters: parameters) { response in
                print(response.debugDescription)
                completion(response)
            }
        }
    }

    func completeRegister(parameters: [String:Any], completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void) {
        let completeRegisterURL = url(from: nil, path: ClientConstants.Constants.APIPath,
                                      method: ClientConstants.Methods.Profile.edit)

        alamofireRequest(url: completeRegisterURL, method: .post, parameters: parameters) { [weak self] response in
            guard let response = self?.serverResponse(from: response.data) else {
                completion(.unknownError)
                return
            }

            completion(response)
        }
    }

}

// MARK: - Profile

extension SocialNetworkClient {

    func getProfile(_ userID: UserID? = nil, completion: @escaping (ClientConstants.ProfileRequest) -> Void) {
        let method: String
        if let userID = userID {
            method = String(format: ClientConstants.Methods.Profile.byID, userID)
        }
        else {
            method = ClientConstants.Methods.Profile.me
        }

        let profileURL = url(from: nil, path: ClientConstants.Constants.APIPath,
                             method: method)

        alamofireRequest(url: profileURL) { response in
            guard let json = response.result.value as? [String:Any] else {
                completion(.fail(.unknownError))
                return
            }
            
            let profile = User(from: json)
            if userID == nil {
                Settings.userId = profile.id
            }
            completion(.success(profile))
        }
    }

    func editProfile(with parameters: [String:Any], completion: @escaping (ClientConstants.ServerResponse?) -> Void) {
        let editURL = url(from: nil, path: ClientConstants.Constants.APIPath,
                          method: ClientConstants.Methods.Profile.edit)

        alamofireRequest(url: editURL, method: .post, parameters: parameters) { response in
            print(response)
        }
    }

    func logout(completion: @escaping (ClientConstants.ServerResponse?) -> Void) {
        let logoutURL = url(from: nil, path: ClientConstants.Constants.APIPath,
                            method: ClientConstants.Methods.logout)

        alamofireManager?.request(logoutURL).validate()

        alamofireManager?.adapter = nil
        alamofireManager?.retrier = nil
        Settings.launchedFirstTime = true
        Settings.registerComplete = false
        Settings.signedIn = false
        Settings.username = nil
        Settings.password = nil
        Settings.userId = nil
    }

}

// MARK: - Search

extension SocialNetworkClient {

    func search(parameters: [String:Any], query: [String:Any],
                completion: @escaping (ClientConstants.SearchRequest) -> Void) {
        let searchURL = url(from: query, path: ClientConstants.Constants.APIPath,
                            method: ClientConstants.Methods.Search.path)

        alamofireRequest(url: searchURL, method: .post, parameters: parameters) { response in
            guard let dicts = response.result.value as? [[String:Any]] else {
                completion(.fail(.unknownError))
                return
            }

            var users = [User]()
            dicts.forEach { users.append(User(from: $0)) }
            users.forEach { UserManager.shared.add(entry: $0) }
            completion(.success(users))
        }
    }

}
