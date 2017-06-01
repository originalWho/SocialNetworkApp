import Alamofire

// MARK: - Register

extension SocialNetworkClient {
    
    func register(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void ) {
        let registerURL = url(from: nil, path: Constants.APIPath, method: Methods.Register)

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
            parameters[OAuth.ParameterKeys.GrantType] = OAuth.GrantType.password
            this.authenticate(parameters: parameters) { response in
                print(response.debugDescription)
                completion(response)
            }
        }
    }

    func completeRegister(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void) {
        let completeRegisterURL = url(from: nil, path: Constants.APIPath, method: Methods.Profile.Edit)

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

    enum ProfileRequest {
        case fail(ServerResponse)
        case success(User)
    }

    func getProfile(_ userId: Int? = nil, completion: @escaping (ProfileRequest) -> Void) {
        let method = (userId == nil)
            ? Methods.Profile.Me
            : String(format: Methods.Profile.ByID, userId!)
        let profileURL = url(from: nil, path: Constants.APIPath, method: method)

        alamofireRequest(url: profileURL) { response in
            guard let json = response.result.value as? [String:Any] else {
                    completion(.fail(.unknownError))
                return
            }
            
            let profile = User(from: json)
            if userId == nil {
                Settings.userId = profile.id
            }
            completion(.success(profile))
        }
    }

    func editProfile(with parameters: [String:Any], completion: @escaping (ServerResponse?) -> Void) {
        let editURL = url(from: nil, path: Constants.APIPath, method: Methods.Profile.Edit)

        alamofireRequest(url: editURL, method: .post, parameters: parameters) { response in
            print(response)
        }
    }

    func logout(completion: @escaping (ServerResponse?) -> Void) {
        let logoutURL = url(from: nil, path: Constants.APIPath, method: Methods.Logout)

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

    enum SearchRequest {
        case fail(ServerResponse)
        case success([User])
    }

    func search(parameters: [String:Any], query: [String:Any], completion: @escaping (SearchRequest) -> Void) {
        let searchURL = url(from: query, path: Constants.APIPath, method: Methods.Search.Path)

        alamofireRequest(url: searchURL, method: .post, parameters: parameters) { response in
            guard let dicts = response.result.value as? [[String:Any]] else {
                completion(.fail(.unknownError))
                return
            }

            var users = [User]()
            dicts.forEach { users.append(User(from: $0)) }
            completion(.success(users))
        }
    }
}
