import Foundation
import Alamofire

final class YandexTranslate: BaseTranslateService {

    private var serviceIdentifier: String {
        return "Yandex.Translate"
    }
    private var url: String {
        return "https://translate.yandex.net/api/v1.5/tr.json/translate"
    }
    private var apiKey: String {
        return ""
    }

    private struct QueryKey {
        static let key = "key"
        static let text = "text"
        static let lang = "lang"
        static let format = "format"
        static let options = "options"
    }

    init?() {
        super.init(identifier: serviceIdentifier, url: url, apiKey: apiKey)
    }

    // MARK: - TranslateService protocol

    override func translate(_ text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {
        guard !text.value.isEmpty else {
            completion(text, nil)
            return
        }

        var parameters = [String: Any]()
        parameters[QueryKey.key] = apiKey
        parameters[QueryKey.text] = text.value
        parameters[QueryKey.lang] = "ru"

        let url = createURL(with: parameters)
        sessionManager.request(url).validate().responseJSON { response in
            guard let response = response.result.value as? [String:Any],
                let textArray = response[QueryKey.text] as? NSArray,
                let translatedText = textArray[0] as? String else {
                    completion(text, nil)
                    return
            }

            completion(text, translatedText)
            
            let translatedWord = TranslatedText(original: text, translated: translatedText)
            TranslateManager.shared.add(entry: translatedWord)
        }
    }

    func translate(_ text: String?, completion: @escaping (String?) -> Void) {
        guard let text = text, !text.isEmpty else { return }

        var parameters = [String: Any]()
        parameters[QueryKey.key] = apiKey
        parameters[QueryKey.text] = text
        parameters[QueryKey.lang] = "ru"

        let url = createURL(with: parameters)
        sessionManager.request(url).validate().responseJSON { response in
            guard let response = response.result.value as? [String:Any],
                let textArray = response[QueryKey.text] as? NSArray,
                let translatedText = textArray[0] as? String else {
                    completion(nil)
                    return
            }

            completion(translatedText)

//            let translatedWord = TranslatedText(original: text, translated: translatedText)
//            TranslateManager.shared.add(entry: translatedWord)
        }
    }

}
