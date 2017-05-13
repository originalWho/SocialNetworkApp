import UIKit

// MARK: UIViewController Constants

extension UIViewController {

    struct Constants {
        struct Patterns {
            static let Name = "[A-Za-z]{2,20}"
            static let Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            static let Password = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        }
    }

    enum WarningMessage: String {
        case incorrectName = "Incorrect name"
        case incorrectEmail = "Incorrect E-mail"
        case incorrectPassword = "Incorrect password"
        case weakPassword = "Password is too weak"
        case notChosenCountry = "Country is not chosen"
        case notChosenBirthday = "Birthday is not chosen"
        case notChosenMotherLanguage = "Mother language is not chosen"
        case unknownError = "Unknown Error"
    }

}

extension UIStoryboard {

    static var ID: String { return "Main" }
    static var Main: String { return "MainTabViewController" }
    static var Login: String { return  "LoginViewController" }
    static var Register: String { return "RegisterViewController" }
    static var CompleteRegister: String { return "CompleteRegisterViewController" }
    static var Chat: String { return  "ChatViewController" }
    static var TranslateBottomSheet: String { return "TranslateBottomSheetViewController" }
    static var Profile: String { return "ProfileViewController" }
    
}

extension UITableViewCell {

    static var Search: String { return "SearchTableViewCell" }
    
}

extension UIStoryboardSegue {

    static var ShowProfile: String { return "showProfile" }
    
}
