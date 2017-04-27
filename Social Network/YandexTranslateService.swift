import Foundation
import Alamofire

class YandexTranslate: BaseTranslateService {

    private let url = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    private let apiKey = "trnsl.1.1.20170427T151422Z.084e82edd3e294da.7974a9ce7e4f2d6a87a1b387c3e2899f1a8954c9"

    private struct QueryKey {
        static let key = "key"
        static let text = "text"
        static let lang = "lang"
        static let format = "format"
        static let options = "options"
    }

    init() {
        super.init(url: url, apiKey: apiKey)!
    }

    override func translate(_ text: String, completion: @escaping (String?) -> Void) {
        guard !text.isEmpty else {
            completion(nil)
            return
        }

        var parameters = [String: Any]()
        parameters[QueryKey.key] = apiKey
        parameters[QueryKey.text] = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        parameters[QueryKey.lang] = "ru"

        let url = makeURL(with: parameters)
        sessionManager.request(url).validate().responseJSON { response in
            guard let response = response.result.value as? [String:Any] else {
                    completion(nil)
                    return
            }
            completion("translatedText")
        }
    }

}
