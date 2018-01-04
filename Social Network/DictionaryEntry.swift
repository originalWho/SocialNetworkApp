import UIKit

struct DictionaryEntry: Storable {

    let value: String
    let context: String?
    var photo: UIImage?
    var language: LanguageName
    var lexicalClass: DictionaryLexicalClass
    var definitions: [AssociatedWord]?
    var synonyms: [AssociatedWord]?
    var antonyms: [AssociatedWord]?
    var usageExamples: [AssociatedWord]?

    var hashValue: Int {
        return value.hashValue ^ lexicalClass.hashValue ^ language.hashValue
    }

    init(value: String, context: String?, photo: UIImage? = nil, language: LanguageName, lexicalClass: DictionaryLexicalClass) {
        self.value = value
        self.context = context
        self.photo = photo
        self.language = language
        self.lexicalClass = lexicalClass
    }

    static func <(lhs: DictionaryEntry, rhs: DictionaryEntry) -> Bool {
        return lhs.value < rhs.value
            && lhs.lexicalClass.rawValue < rhs.lexicalClass.rawValue
            && lhs.language.rawValue < rhs.language.rawValue
    }

    static func ==(lhs: DictionaryEntry, rhs: DictionaryEntry) -> Bool {
        return lhs.value == rhs.value
            && lhs.lexicalClass == rhs.lexicalClass
            && lhs.language == rhs.language
    }

}

extension LSExtractedWord {

    var dictionaryEntry: DictionaryEntry {
        return DictionaryEntry(value: value,
                               context: context,
                               language: dominantLanguage,
                               lexicalClass: DictionaryLexicalClass(linguisticTag: lexicalClass))
    }

}

// MARK: - DictionaryLexicalClass enum

enum DictionaryLexicalClass: Int {
    case noun
    case verb
    case adjective
    case adverb
    case pronoun
    case determiner
    case particle
    case preposition
    case number
    case classifier
    case personalName
    case placeName
    case organizationName
    case phrase

    init(linguisticTag: NSLinguisticTag) {
        switch linguisticTag {
        case .noun:
            self = .noun

        case .verb:
            self = .verb

        case .adjective:
            self = .adjective

        case .adverb:
            self = .adverb

        case .pronoun:
            self = .pronoun

        case .determiner:
            self = .determiner

        case .particle:
            self = .particle

        case .preposition:
            self = .preposition

        case .number:
            self = .number

        case .classifier:
            self = .classifier

        case .personalName:
            self = .personalName

        case .organizationName:
            self = .organizationName

        default:
            self = .phrase
        }
    }

    var localized: String {
        return "Lexical class"
    }
}

// MARK: - AssociatedWord struct

struct AssociatedWord: Hashable, Comparable {

    let meaning: String
    let lexicalClass: DictionaryLexicalClass
    let associated: [String]

    var hashValue: Int {
        return meaning.hashValue
    }

    static func ==(lhs: AssociatedWord, rhs: AssociatedWord) -> Bool {
        return lhs.meaning == rhs.meaning
    }

    static func <(lhs: AssociatedWord, rhs: AssociatedWord) -> Bool {
        return lhs.meaning < rhs.meaning
    }

}
