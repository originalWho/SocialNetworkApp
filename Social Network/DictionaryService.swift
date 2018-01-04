import Foundation

struct DSLookUpResult {
    var definitions: [AssociatedWord]
    var synonyms: [AssociatedWord]
    var antonyms: [AssociatedWord]
    var usageExamples: [AssociatedWord]
}

protocol DictionaryService {

    func lookUp(_ word: LSExtractedWord, completion: @escaping (LSExtractedWord, DSLookUpResult?) -> Void)

}

class BaseDictionaryService: BaseThirdPartyService, DictionaryService {

    // MARK: - ThirdPartyService protocol

    override func fetchInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {
        assertionFailure("Must be overridden in subclass")
    }

    // MARK: - DictionaryService protocol

    func lookUp(_ word: LSExtractedWord, completion: @escaping (LSExtractedWord, DSLookUpResult?) -> Void) {
        assertionFailure("Must be overridden in subclass")
    }

}
