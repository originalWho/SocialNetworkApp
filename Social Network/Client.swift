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
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        alamofireManager?.adapter = retrier
        alamofireManager?.retrier = retrier
    }
    
    func url(from parameters: [String:AnyObject]?, path: String, method: String) -> URL {
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
    
}
