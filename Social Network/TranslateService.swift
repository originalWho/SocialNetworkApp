import Foundation
import Alamofire

struct TranslatedText: Storable {

    let original: LSExtractedWord
    let translated: String?
    let time: Date = Date()
    var hashValue: Int {
        return original.value.hashValue
    }

    static func <(lhs: TranslatedText, rhs: TranslatedText) -> Bool {
        return lhs.time < rhs.time && lhs.original.value < rhs.original.value
    }

    static func ==(lhs: TranslatedText, rhs: TranslatedText) -> Bool {
        return lhs.original.value == rhs.original.value
    }

}

// MARK: - TranslateService protocol

protocol TranslateService: ThirdPartyService {

    func translate(_ text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void)
    func translate(_ text: LSExtractedWord, from: LanguageName?, to: LanguageName?, completion: @escaping (LSExtractedWord, String?) -> Void)
    
}

// MARK: - BaseTranslateService

class BaseTranslateService: BaseThirdPartyService, TranslateService {

    // MARK: - ThirdPartyService protocol

    override var description: String {
        return "Translation"
    }

    override func fetchInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {
        translate(text) { originalText, translatedText in
            completion(originalText, translatedText)
        }
    }

    // MARK: - TranslateService protocol

    func translate(_ text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {
        assertionFailure("translate(_:completion) must be overridden in BaseTranslateService subclass")
    }

    func translate(_ text: LSExtractedWord, from: LanguageName?, to: LanguageName?, completion: @escaping (LSExtractedWord, String?) -> Void) {
        assertionFailure("translate(_:from:to:completion) must be overridden in BaseTranslateService subclass")
    }

}
