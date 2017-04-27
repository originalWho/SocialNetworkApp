import Foundation
import Alamofire

// MARK: - TranslateService protocol

protocol TranslateService {
    func translate(_ text: String, completion: @escaping (String?) -> Void)
    func translate(_ text: String, from: LanguageName?, to: LanguageName?, completion: @escaping (String?) -> Void)
}


// MARK: - BaseTranslateService

class BaseTranslateService: TranslateService {

    // MARK: - Private properties

    private let baseURL: URLComponents
    private let apiKey: String
    let sessionManager: SessionManager

    // MARK: - Init

    init?(url: String, apiKey: String) {
        guard let urlComponents = URLComponents(string: url) else {
            return nil
        }

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
        components.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }

        return components.url!
    }

}
