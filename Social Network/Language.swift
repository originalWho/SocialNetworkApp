import Foundation

struct Language {
    let name: LanguageName
    let level: LanguageLevel
    var dictionary: [String:Int] {
        return ["\(name.rawValue)":level.rawValue]
    }

    init(with name: LanguageName, and level: LanguageLevel) {
        self.name = name
        self.level = level
    }
}
