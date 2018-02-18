import Foundation

protocol ChatBottomSheetInfoProvider {

    var description: String { get }
    var name: String { get }

    func fetchInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void)

}

enum ChatBottomSheetViewControllerStrategy {
    case none
    case translation
    case lookUp

    var infoProviders: [ChatBottomSheetInfoProvider] {
        switch self {
        case .none:
            return []
            
        case .translation:
            if let yandexTranslate = YandexTranslate() {
                return [yandexTranslate]
            }
            else {
                return []
            }

        case .lookUp:
            if let yandexDictionary = YandexDictionary() {
                return yandexDictionary.infoProviders
            }
            else {
                return [/* definitions, synonyms, antonyms, usage examples */]
            }
        }
    }
    
}
