import Foundation
import OAuth2
import Alamofire

final class OAuth2RetryHandler: RequestRetrier, RequestAdapter {
    
    let loader: OAuth2DataLoader
    
    init(oauth2: OAuth2) {
        loader = OAuth2DataLoader(oauth2: oauth2)
    }

    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        guard let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401,
            let req = request.request else {
                completion(false, 0.0)
                return
        }

        var dataRequest = OAuth2DataRequest(request: req, callback: { _ in })
        dataRequest.context = completion
        loader.enqueue(request: dataRequest)
        loader.attemptToAuthorize() { [weak self] authParams, error in
            self?.loader.dequeueAndApply() { req in
                if let comp = req.context as? RequestRetryCompletion {
                    comp(authParams != nil, 0.0)
                }
            }
        }
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard loader.oauth2.accessToken != nil else {
            return urlRequest
        }
        return try urlRequest.signed(with: loader.oauth2)
    }

}
