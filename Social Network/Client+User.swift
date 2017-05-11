import Alamofire

// MARK: - Register

extension SocialNetworkClient {
    
    func register(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void ) {
        let registerURL = url(from: nil, path: Constants.APIPath, method: Methods.Register)
        
        alamofireManager?
            .request(registerURL,
                     method: .post,
                     parameters: parameters,
                     encoding: JSONEncoding.default,
                     headers: nil)
            .validate()
            .responseString { [weak self] response in
                guard let this = self else {
                    completion(nil)
                    return
                }

                let response = this.serverResponse(from: response.data)
                guard response == .success else {
                    completion(nil)
                    return
                }

                var parameters = parameters
                parameters[OAuth.ParameterKeys.GrantType] = OAuth.GrantType.password
                this.authenticate(parameters: parameters) { response in
                    completion(response)
                }
        }
    }

    func completeRegister(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void) {
        let completeRegisterURL = url(from: nil, path: Constants.APIPath, method: Methods.Profile.Edit)

        alamofireManager?
            .request(completeRegisterURL,
                     method: .post,
                     parameters: parameters,
                     encoding: JSONEncoding.default,
                     headers: nil)
            .validate()
            .response(completionHandler: { [weak self] response in
                guard let response = self?.serverResponse(from: response.data) else {
                    completion(.unknownError)
                    return
                }
                
                completion(response)
            })
    }

}

// MARK: - Profile

extension SocialNetworkClient {

    func getProfile(_user: String? = nil, completion: @escaping (String) -> Void) {

    }

    func editProfile(with parameters: [String:Any], completion: @escaping (String) -> Void) {

    }

    func logout(completion: @escaping (String) -> Void) {
        
    }

}
