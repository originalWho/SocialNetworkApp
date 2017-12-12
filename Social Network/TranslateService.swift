import Foundation
import Alamofire

// MARK: - TranslateService protocol

protocol TranslateService {
    var identifier: String { get }
    func translate(_ text: String, completion: @escaping (String?) -> Void)
    func translate(_ text: String, from: LanguageName?, to: LanguageName?, completion: @escaping (String?) -> Void)
}

// MARK: - BaseTranslateService

class BaseTranslateService: TranslateService {

    // MARK: - Internal properties

    let identifier: String

    // MARK: - Private properties

    private let baseURL: URLComponents
    private let apiKey: String
    let sessionManager: SessionManager

    // MARK: - Init

    init?(identifier: String, url: String, apiKey: String) {
        guard let urlComponents = URLComponents(string: url) else {
            return nil
        }

        self.identifier = identifier
        self.baseURL = urlComponents
        self.apiKey = apiKey
        self.sessionManager = SessionManager()
    }

    // MARK: - TranslateService protocol

    func translate(_ text: String, completion: @escaping (String?) -> Void) {
        /////////////////////////////////////////////
        /// BaseTranslateService should not translate
        /// Only derived classes should translate
        /////////////////////////////////////////////
        completion(nil)
    }

    func translate(_ text: String, from: LanguageName?, to: LanguageName?, completion: @escaping (String?) -> Void) {
        /////////////////////////////////////////////
        /// BaseTranslateService should not translate
        /// Only derived classes should translate
        /////////////////////////////////////////////
        completion(nil)
    }

    // MARK: - Private methods 

    func makeURL(with parameters: [String:Any]) -> URL {
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
