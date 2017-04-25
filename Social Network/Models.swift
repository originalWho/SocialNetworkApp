import Foundation

// MARK: Structs

struct Language {

    let name: LanguageName
    let level: LanguageLevel

    init(with name: LanguageName, and level: LanguageLevel) {
        self.name = name
        self.level = level
    }

}
