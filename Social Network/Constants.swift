import UIKit

// MARK: UIViewController Constants

extension UIViewController {

    enum ValidationPattern: String {
        case name = "[A-Za-z]{2,20}"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
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

    enum Main {

        static var id: String {
            return "Main"
        }

        static var tabViewController: String {
            return "MainTabViewController"
        }

    }

    enum Search {

        static var id: String {
            return "Search"
        }

    }

    enum Profile {

        static var id: String {
            return "Profile"
        }

    }

    enum Conversations {

        static var id: String {
            return "Conversations"
        }

    }
    
}

extension UIStoryboardSegue {

    static var ShowProfile: String { return "showProfile" }
    
}
