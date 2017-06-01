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

    static var ID: String { return "Main" }
    static var Main: String { return "MainTabViewController" }
    static var Login: String { return  "LoginViewController" }
    static var Register: String { return "RegisterViewController" }
    static var CompleteRegister: String { return "CompleteRegisterViewController" }
    static var Chat: String { return  "ChatViewController" }
    static var ChatHelper: String { return "ChatHelperViewController" }
    static var ChatPage: String { return "ChatPageViewController" }
    static var TranslateBottomSheet: String { return "TranslateBottomSheetViewController" }
    static var Profile: String { return "ProfileViewController" }
    static var ProfileEdit: String { return "ProfileEditViewController" }
    static var UserList: String { return "UserListTableViewController" }
    static var SearchParameters: String { return "SearchParametersViewController" }
    static var SearchParameterSelection: String { return "SearchParameterSelectionViewController" }
    
}

extension UITableViewCell {

    static var Search: String { return "SearchTableViewCell" }
    static var SearchParameterCheckmark: String { return "SearchParameterCheckmarkTableViewCell" }
    static var SearchParameterDisclosure: String { return "SearchParameterDisclosureTableViewCell" }
    static var SearchParameterSelection: String { return "SearchParameterSelectionTableViewCell" }

}

extension UIStoryboardSegue {

    static var ShowProfile: String { return "showProfile" }
    
}
