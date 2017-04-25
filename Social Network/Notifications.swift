import Foundation

struct UINotification {

    static var CountryPicked: NSNotification.Name {
        return NSNotification.Name(rawValue: "uiNotification.countryPicked")
    }

    static var LanguagePicked: NSNotification.Name {
        return NSNotification.Name(rawValue: "uiNotification.languagePicked")
    }

}
