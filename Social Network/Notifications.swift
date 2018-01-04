import Foundation

extension NSNotification.Name {

    static var translateSelected: NSNotification.Name {
        return NSNotification.Name(rawValue: "notification.translateSelected")
    }

    static var commentSelected: NSNotification.Name {
        return NSNotification.Name(rawValue: "notification.commentSelected")
    }

    static var lookUpSelected: NSNotification.Name {
        return NSNotification.Name(rawValue: "notification.lookUpSelected")
    }

    static var addSelectedToDictionary: NSNotification.Name {
        return NSNotification.Name(rawValue: "notification.addSelectedToDictionary")
    }

}
