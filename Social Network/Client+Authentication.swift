import Alamofire

// MARK: - Public methods

extension SocialNetworkClient {
    
    func authenticate(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void ) {
        guard let grantType = parameters[OAuth.ParameterKeys.GrantType] as? OAuth.GrantType else {
            return
        }
        
        switch grantType {
        case .code:
            authenticateWithCode(parameters: parameters) { response in
                completion(response)
            }
            
        case .password:
            authenticateWithPassword(parameters: parameters) { response in
                completion(response)
            }

        case .clientCredentials, .implicit:
            // Do Nothing
            break
        }
    }
    
}

// MARK: - Private methods

fileprivate extension SocialNetworkClient {

    private typealias Key = SocialNetworkClient.OAuth.ParameterKeys
    
    func authenticateWithPassword(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void) {
        guard let username = parameters[ParameterKeys.Email] as? String,
            let password = parameters[Key.Password] as? String else {
                completion(nil)
                return
        }

        let oauth = OAuthInstance.Default
        oauth.username = username
        oauth.password = password
        setOAuth(oauth2: oauth)

        alamofireManager?
            .request("https://localhost:8443/api/secured")
            .response(completionHandler: { response in
                guard let response = response.response else {
                    completion(nil)
                    return
                }

                let result: ServerResponse = (response.statusCode < 400)
                    ? .success
                    : .accessDenied

                if result == .success {
                    Settings.username = username
                    Settings.password = password
                    Settings.signedIn = true
                }
                
                completion(result)
            })
    }

    func authenticateWithCode(parameters: [String:Any], completion: @escaping (_ response: ServerResponse?) -> Void) {
        guard let service = parameters[Key.Service]
            as? SocialNetworkClient.OAuth.Service else {
                return
        }
        
        switch service {
        case .facebook:
            break
            
        case .google:
            break
        }
    }
    
}
