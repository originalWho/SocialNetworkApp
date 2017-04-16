import Foundation

struct Constants {

    struct Patterns {
        static let Name = "[A-Za-z]{2,20}"
        static let Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let Password = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
    }
    
    struct WarningMessage {
        static let IncorrectName = "Incorrect name"
        static let IncorrectEmail = "Incorrect E-mail"
        static let IncorrectPassword = "Incorrect password"
        static let WeakPassword = "Password is too weak"
    }

}
