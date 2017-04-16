import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Typealiases

    fileprivate typealias ParameterKeys = SocialNetworkClient.ParameterKeys
    fileprivate typealias WarningMessage = Constants.WarningMessage

    // MARK: - Outlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    // MARK: - Private properties

    fileprivate let client = SocialNetworkClient.default

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        indicator.isHidden = true
    }

}

extension RegisterViewController {

    @IBAction func signup(_ sender: Any) {
        signupButton.isEnabled = false
        signupButton.isHidden = true
        warningLabel.isHidden = true
        indicator.isHidden = false
        
        func warn(with: String) {
            signupButton.isEnabled = true
            signupButton.isHidden = false
            warningLabel.isHidden = false
            warningLabel.text = with
            indicator.isHidden = true
        }
        
        func validate(string: String, pattern: String) -> Bool {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            return predicate.evaluate(with: string)
        }
        
        guard let name = nameTextField.text, !name.isEmpty,
            validate(string: name, pattern: Constants.Patterns.Name) else {
            warn(with: WarningMessage.IncorrectName)
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty,
            validate(string: email, pattern: Constants.Patterns.Email) else {
            warn(with: WarningMessage.IncorrectEmail)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty,
            validate(string: password, pattern: Constants.Patterns.Password) else {
            warn(with: WarningMessage.WeakPassword)
            return
        }
        
        let parameters = [
            ParameterKeys.Name: name,
            ParameterKeys.Email: email,
            ParameterKeys.Password: password
        ]
        
        client.register(parameters: parameters) { [weak self] response in
            // TODO: Present CompleteRegisterViewController
        }
    }
}
