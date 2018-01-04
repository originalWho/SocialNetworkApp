import Foundation

final class YandexDictionary: BaseDictionaryService {

    private var serviceIdentifier: String {
        return "Yandex.Dictionary"
    }
    private var url: String {
        return "https://dictionary.yandex.net/api/v1/dicservice.json/lookup"
    }
    private var apiKey: String {
        return ""
    }

    private var cache: [LSExtractedWord: DSLookUpResult] = [:]

    private struct QueryKey {
        static let key = "key"
        static let text = "text"
        static let lang = "lang"
        static let ui = "ui"
        static let flags = "flags"
    }

    private struct ResponseKey {
        static let head = "head"
        static let def = "def"
        static let tr = "tr"
        static let syn = "syn"
        static let mean = "mean"
        static let ex = "ex"

        static let ts = "ts"
        static let text = "text"
        static let num = "num"
        static let pos = "pos"
        static let gen = "gen"
    }

    var infoProviders: [ChatBottomSheetInfoProvider] {
        let definitionsProvider = YandexDictionaryEntryProvider(dictionary: self, type: .defininitions, name: serviceIdentifier)
        let synonymsProvider = YandexDictionaryEntryProvider(dictionary: self, type: .synonyms, name: serviceIdentifier)
        let antonymsProvider = YandexDictionaryEntryProvider(dictionary: self, type: .antonyms, name: serviceIdentifier)
        let usageExamplesProvider = YandexDictionaryEntryProvider(dictionary: self, type: .usageExamples, name: serviceIdentifier)
        return [definitionsProvider, synonymsProvider, antonymsProvider, usageExamplesProvider]
    }
    private var completionClosures: [LSExtractedWord: [(LSExtractedWord, DSLookUpResult?) -> Void]] = [:]

    init?() {
        super.init(identifier: serviceIdentifier, url: url, apiKey: apiKey)
    }

    override func fetchInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {

    }

    // MARK: - DictionaryService protocol

    override func lookUp(_ word: LSExtractedWord, completion: @escaping (LSExtractedWord, DSLookUpResult?) -> Void) {
        guard !word.value.isEmpty else {
            completion(word, nil)
            return
        }

        guard cache[word] == nil else {
            completion(word, cache[word])
            return
        }

        guard completionClosures[word] == nil else {
            completionClosures[word]?.append(completion)
            return
        }

        completionClosures[word] = [completion]

        var parameters = [String: Any]()
        parameters[QueryKey.key] = apiKey
        parameters[QueryKey.text] = word.value
        parameters[QueryKey.lang] = "en-ru"

        let url = createURL(with: parameters)

        sessionManager.request(url).validate().responseJSON { [weak self] response in
            guard let response = response.result.value as? [String: Any],
                let definitions = response[ResponseKey.def] as? NSArray else {
                    self?.executeClosures(for: word, with: nil)
                    return
            }

            let result = self?.parse(definitions: definitions)
            self?.cache[word] = result
            self?.executeClosures(for: word, with: result)
        }
    }

    private func executeClosures(for word: LSExtractedWord, with result: DSLookUpResult?) {
        if let closures = completionClosures[word] {
            closures.forEach { $0(word, result) }
            completionClosures[word] = nil
        }
    }

    private func parse(definitions: NSArray) -> DSLookUpResult {
        var meanings: [AssociatedWord] = []
        var synonyms: [AssociatedWord] = []
        var usageExamples: [AssociatedWord] = []

        for definition in definitions {
            guard let definition = definition as? [String: Any],
                let translations = definition[ResponseKey.tr] as? NSArray else { continue }

            for translation in translations {
                guard let translation = translation as? [String: Any] else { continue }
                let meaning = translation[ResponseKey.text]
            }
        }


        return DSLookUpResult(definitions: meanings,
                              synonyms: synonyms,
                              antonyms: [],
                              usageExamples: usageExamples)
    }

}

struct YandexDictionaryEntryProvider: ChatBottomSheetInfoProvider {

    enum InfoType {
        case defininitions
        case synonyms
        case antonyms
        case usageExamples

        fileprivate var description: String {
            switch self {
            case .defininitions:
                return "Definitions"

            case .synonyms:
                return "Synonyms"

            case .antonyms:
                return "Antonyms"

            case .usageExamples:
                return "Usage Examples"
            }
        }
    }

    var dictionary: YandexDictionary?

    var type: InfoType
    var name: String
    var description: String {
        return type.description
    }

    func fetchInfo(for text: LSExtractedWord, completion: @escaping (LSExtractedWord, String?) -> Void) {
        dictionary?.lookUp(text) { _, result in
            switch self.type {
            case .defininitions:
                return completion(text, result?.definitions.first?.meaning)

            case .synonyms:
                return completion(text, result?.synonyms.first?.meaning)

            case .antonyms:
                return completion(text, result?.antonyms.first?.meaning)

            case .usageExamples:
                return completion(text, result?.usageExamples.first?.meaning)
            }
        }
    }

}
