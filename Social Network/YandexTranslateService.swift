import Foundation
import Alamofire

final class YandexTranslate: BaseTranslateService {

    private let serviceIdentifier = "Yandex.Translate"
    private let url = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    private let apiKey = ""

    private struct QueryKey {
        static let key = "key"
        static let text = "text"
        static let lang = "lang"
        static let format = "format"
        static let options = "options"
    }

    init() {
        super.init(identifier: serviceIdentifier, url: url, apiKey: apiKey)!
    }

    override func translate(_ text: String, completion: @escaping (String?) -> Void) {
        guard !text.isEmpty else {
            completion(nil)
            return
        }

        var parameters = [String: Any]()
        parameters[QueryKey.key] = apiKey
        parameters[QueryKey.text] = text
        parameters[QueryKey.lang] = "ru"

        let url = makeURL(with: parameters)
        sessionManager.request(url).validate().responseJSON { response in
            guard let response = response.result.value as? [String:Any],
                let textArray = response[QueryKey.text] as? NSArray,
                let text = textArray[0] as? String else {
                    completion(nil)
                    return
            }
            completion(text)
        }
    }

}
