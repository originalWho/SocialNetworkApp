import Foundation
import Alamofire

protocol ThirdPartyService {

    var identifier: String { get }

}

// MARK: - BaseTranslateService

class BaseThirdPartyService: ThirdPartyService, ChatBottomSheetInfoProvider {

    // MARK: - Private static properties

    private static let thirdPartySessionManager = SessionManager()

    // MARK: - ThirdPartyService protocol

    let identifier: String

    // MARK: - Private properties

    private let baseURL: URLComponents
    private let apiKey: String
    let sessionManager: SessionManager

    // MARK: - Init

    init?(identifier: String, url: String, apiKey: String,
          sessionManager: SessionManager = BaseThirdPartyService.thirdPartySessionManager) {
        guard let urlComponents = URLComponents(string: url) else {
            return nil
        }

        self.identifier = identifier
        self.baseURL = urlComponents
        self.apiKey = apiKey
        self.sessionManager = sessionManager
    }

    // MARK: - ChatBottomSheetInfoProvider

    var description: String {
        assertionFailure("Must be overridden in subclass")
        return ""
    }

    var name: String {
        return identifier
    }

    func fetchInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {
        assertionFailure("Must be overridden in subclass")
        completion(text, nil)
    }

    func fetchMultipleInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, [String]?) -> Void) {
        assertionFailure("Must be overridden in subclass")
        completion(text, nil)
    }

    // MARK: - Private methods

    func createURL(with parameters: [String:Any]) -> URL {
        var components = baseURL
        var queryItems = [URLQueryItem]()

        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems.append(queryItem)
        }

        components.queryItems = queryItems
        return components.url!
    }

}
