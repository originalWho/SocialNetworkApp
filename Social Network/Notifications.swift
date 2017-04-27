import Foundation

extension NSNotification.Name {

    static var UICountryPicked: NSNotification.Name {
        return NSNotification.Name(rawValue: "uiNotification.countryPicked")
    }

    static var UILanguagePicked: NSNotification.Name  {
        return NSNotification.Name(rawValue: "uiNotification.languagePicked")
    }

    static var UITranslateSelected: NSNotification.Name {
        return NSNotification.Name(rawValue: "uiNotification.translateSelected")
    }

    static var UICommentSelected: NSNotification.Name {
        return NSNotification.Name(rawValue: "uiNotification.commentSelected")
    }

}
