import UIKit

class LoginViewController: UIViewController {

    // MARK: - Typealiases
    fileprivate typealias OAuth = SocialNetworkClient.OAuth
    fileprivate typealias ParameterKeys = SocialNetworkClient.ParameterKeys
    fileprivate typealias WarningMessage = Constants.WarningMessage

    // MARK: - Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    // MARK: - Private properties

    fileprivate let client = SocialNetworkClient.default

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
    }

}

// MARK: - Actions

extension LoginViewController {

    @IBAction func signIn(_ sender: Any) {
        signinButton.isEnabled = false
        signinButton.isHidden = true
        indicator.isHidden = false
        
        func warn(with: String) {
            signinButton.isEnabled = true
            signinButton.isHidden = false
            indicator.isHidden = true
        }
        
        func validate(string: String, pattern: String) -> Bool {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            return predicate.evaluate(with: string)
        }
        
        guard let email = emailTextField.text, !email.isEmpty,
            validate(string: email, pattern: Constants.Patterns.Email) else {
            warn(with: WarningMessage.IncorrectEmail)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty,
            validate(string: password, pattern: Constants.Patterns.Password) else {
            warn(with: WarningMessage.IncorrectPassword)
            return
        }
        
        let parameters = [
            OAuth.ParameterKeys.GrantType: OAuth.GrantType.Password,
            ParameterKeys.Email: email,
            ParameterKeys.Password: password
        ] as [String : Any]
        
        client.authenticate(parameters: parameters) { response in
            
        }
    }
    
}

