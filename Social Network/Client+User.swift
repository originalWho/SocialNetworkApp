import Alamofire

// MARK: - Public methods

extension SocialNetworkClient {
    
    func register(parameters: [String:Any], completion: ((_ response: ServerResponse?) -> Void)? ) {
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
                    let response = ServerResponse(rawValue: String(data: response.data!, encoding: .utf8)!)
                    completion?(response)
                    return
                }
                
                this.authenticate(parameters: parameters, completion: { response in
                    
                })
                // TODO: Auth
        }
    }
    
}
