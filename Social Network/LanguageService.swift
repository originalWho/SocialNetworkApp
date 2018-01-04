import Foundation

struct LSExtractedWord: Hashable {

    fileprivate(set) var value: String
    fileprivate(set) var context: String?
    fileprivate(set) var lexicalClass: NSLinguisticTag
    fileprivate(set) var dominantLanguage: LanguageName

    var hashValue: Int {
        return value.hashValue ^ lexicalClass.hashValue ^ dominantLanguage.hashValue
    }

    fileprivate init() {
        value = ""
        context = ""
        lexicalClass = .other
        dominantLanguage = .none
    }

    static func ==(lhs: LSExtractedWord, rhs: LSExtractedWord) -> Bool {
        return lhs.value == rhs.value
            && lhs.lexicalClass == rhs.lexicalClass
            && lhs.dominantLanguage == rhs.dominantLanguage
    }
}

final class LanguageService {

    static let shared = LanguageService()

    private let linguisticTagger = NSLinguisticTagger(tagSchemes: .default, options: 0)

    func extractWord(in range: NSRange, from context: String) -> LSExtractedWord? {
        linguisticTagger.string = context

        var extractedWord = LSExtractedWord()
        let context = context as NSString
        let contextRange = NSRange(location: 0, length: context.length)

        let textInRange = context.substring(with: range)
        if textInRange.split(separator: " ").count > 1 {
            extractedWord.value = textInRange.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        }

        linguisticTagger.enumerateTags(in: contextRange, scheme: .lemma, options: .default) { tag, tokenRange, sentenceRange, stop in
            guard range.intersection(tokenRange) != nil, let lemma = tag?._rawValue as String? else { return }

            if extractedWord.value.isEmpty {
                extractedWord.value = lemma.capitalized
            }

            let sentence = context.substring(with: sentenceRange).trimmingCharacters(in: .whitespacesAndNewlines)
            extractedWord.context = sentence

            stop.pointee = true
        }

        linguisticTagger.enumerateTags(in: contextRange, scheme: .nameTypeOrLexicalClass, options: .default) { tag, tokenRange, _, stop in
            guard range == tokenRange, let lexicalClass = tag else { return }
            extractedWord.lexicalClass = lexicalClass
            stop.pointee = true
        }

        extractedWord.dominantLanguage = LanguageName(language: linguisticTagger.dominantLanguage)
        linguisticTagger.string = nil

        return extractedWord
    }

}

// MARK: - Helpers

private extension Array where Element == NSLinguisticTagScheme {

    static var `default`: [NSLinguisticTagScheme] {
        return [.tokenType, .nameTypeOrLexicalClass, .lemma, .language]
    }

}

private extension NSLinguisticTagger.Options {

    static var `default`: NSLinguisticTagger.Options {
        return [.omitPunctuation, .omitWhitespace, .joinNames]
    }

}

private extension LanguageName {

    init(language: String?) {
        guard let language = language else {
            self = .none
            return
        }

        self = .english
    }
}
