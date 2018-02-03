import Foundation
import Alamofire
import OAuth2

protocol Client {

    static var `default`: Client { get }

    func setOAuth(oauth2: OAuth2)

    func authenticate(parameters: [String:Any],
                      completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void)
    func register(parameters: [String:Any],
                  completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void)
    func completeRegister(parameters: [String:Any],
                          completion: @escaping (_ response: ClientConstants.ServerResponse?) -> Void)

    func getProfile(_ userId: UserID?,
                    completion: @escaping (ClientConstants.ProfileRequest) -> Void)
    func search(parameters: [String:Any], query: [String:Any],
                completion: @escaping (ClientConstants.SearchRequest) -> Void)
    
    func send(message: Message, to userId: UserID,
              completion: @escaping (ClientConstants.SendRequest) -> Void)
    func receive(_ mode: ClientConstants.ReceiveMode, from userId: UserID?,
                 completion: @escaping (ClientConstants.MessagesRequest) -> Void)

    func getFriends(of userId: UserID,
                    completion: @escaping (ClientConstants.ActionRequest) -> Void)
    func getSubscribers(of userId: UserID,
                        completion: @escaping (ClientConstants.ActionRequest) -> Void)
    func getSubscribtions(of userId: UserID,
                          completion: @escaping (ClientConstants.ActionRequest) -> Void)
    func getBlacklist(of userId: UserID,
                      completion: @escaping (ClientConstants.ActionRequest) -> Void)

    func friend(_ userId: UserID,
                completion: @escaping (ClientConstants.ActionRequest) -> Void)
    func unfriend(_ userId: UserID,
                  completion: @escaping (ClientConstants.ActionRequest) -> Void)
    func block(_ userId: UserID,
               completion: @escaping (ClientConstants.ActionRequest) -> Void)
    func unblock(_ userId: UserID,
                 completion: @escaping (ClientConstants.ActionRequest) -> Void)

    func editProfile(with parameters: [String:Any],
                     completion: @escaping (ClientConstants.ServerResponse?) -> Void)
    func logout(completion: @escaping (ClientConstants.ServerResponse?) -> Void)
    
}

final class SocialNetworkClient: Client {

    // MARK: - Static properties

    static let `default`: Client = SocialNetworkClient()
    
    // MARK: - Private properties

    fileprivate let serverTrustPolicy: [String: ServerTrustPolicy] = [ClientConstants.Constants.APIHost: .disableEvaluation]      // Debug

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
        oauth2.sessionDelegate = OAuth2DebugURLSessionDelegate(host: ClientConstants.Constants.APIHost)               // Debug
        oauth2.logger = OAuth2DebugLogger(.trace)                                               // Debug
        let retrier = OAuth2RetryHandler(oauth2: oauth2)
        alamofireManager?.adapter = retrier
        alamofireManager?.retrier = retrier
    }
    
    func url(from parameters: [String:Any]?, path: String, method: String) -> URL {
        var components = URLComponents()
        components.scheme = ClientConstants.Constants.APIScheme
        components.host = ClientConstants.Constants.APIHost
        components.port = ClientConstants.Constants.APIPort
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

    func serverResponse(from data: Data?) -> ClientConstants.ServerResponse {
        guard let data = data, let stringValue = String(data: data, encoding: .utf8),
            let intValue = Int(stringValue), let response = ClientConstants.ServerResponse(rawValue: intValue) else {
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
