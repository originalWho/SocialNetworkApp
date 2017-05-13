import Foundation
import Alamofire
import OAuth2

class SocialNetworkClient {

    // MARK: - Static properties

    static let `default`: SocialNetworkClient = SocialNetworkClient()
    
    // MARK: - Private properties

    fileprivate let serverTrustPolicy: [String: ServerTrustPolicy] = ["localhost": .disableEvaluation]      // Debug

    // MARK: - Internal properties

    let alamofireManager: SessionManager?

    // MARK: - Init
    
    init() {
        let serverTrustPolicyManager = ServerTrustPolicyManager(policies: serverTrustPolicy)
        let sessionManager = SessionManager(serverTrustPolicyManager: serverTrustPolicyManager)
        alamofireManager = sessionManager
    }

    // MARK: - Public methods

    func setOAuth(oauth2: OAuth2) {
        oauth2.sessionDelegate = OAuth2DebugURLSessionDelegate(host: "localhost")               // Debug
        oauth2.logger = OAuth2DebugLogger(.trace)                                               // Debug
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        alamofireManager?.adapter = retrier
        alamofireManager?.retrier = retrier
    }
    
    func url(from parameters: [String:Any]?, path: String, method: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.port = Constants.APIPort
        components.path = path
        components.path.append(method)

        guard let parameters = parameters else {
            return components.url!
        }

        components.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems?.append(queryItem)
        }

        return components.url!
    }

    func serverResponse(from data: Data?) -> ServerResponse {
        guard let data = data, let stringValue = String(data: data, encoding: .utf8),
            let intValue = Int(stringValue), let response = ServerResponse(rawValue: intValue) else {
                return .unknownError
        }

        return response
    }

    func alamofireRequest(url: URL, method: HTTPMethod? = .get, parameters: [String:Any]? = nil, completion: @escaping (DataResponse<Any>) -> Void) {
        alamofireManager?
            .request(url,
                     method: method!,
                     parameters: parameters,
                     encoding: JSONEncoding.default,
                     headers: nil)
            .validate()
            .responseJSON(completionHandler: completion)
    }
    
}
