import Alamofire

// MARK: - Public methods

extension SocialNetworkClient {
    
    func authenticate(parameters: [String:Any], completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void) {
        guard let grantType = parameters[ClientConstants.OAuth.ParameterKeys.GrantType] as? ClientConstants.OAuth.GrantType else {
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

    private typealias Key = ClientConstants.OAuth.ParameterKeys
    
    func authenticateWithPassword(parameters: [String:Any], completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void) {
        guard let username = parameters[ClientConstants.ParameterKeys.Email] as? String,
            let password = parameters[Key.Password] as? String else {
                completion(nil)
                return
        }

        let oauth = OAuthInstance.Default
        oauth.username = username
        oauth.password = password
        setOAuth(oauth2: oauth)

        alamofireManager?
            .request("https://\(ClientConstants.Constants.APIHost):8443/api/secured")
            .validate()
            .response() { response in
                guard let response = response.response else {
                    completion(nil)
                    return
                }

                let result: ClientConstants.ServerResponse = (response.statusCode < 400)
                    ? .success
                    : .accessDenied

                if result == .success {
                    Settings.username = username
                    Settings.password = password
                    Settings.signedIn = true
                }
                
                completion(result)
            }
    }

    func authenticateWithCode(parameters: [String:Any], completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void) {
        guard let service = parameters[Key.Service] as? ClientConstants.OAuth.Service else {
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
