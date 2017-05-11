import UIKit

class RegisterViewController: UIViewController {

    // MARK: - Typealiases

    fileprivate typealias ParameterKeys = SocialNetworkClient.ParameterKeys

    // MARK: - Outlets

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
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
        setUI(enabled: false)
        
        func warn(with warning: WarningMessage) {
            warningLabel.text = warning.rawValue
            setUI(enabled: true)
        }
        
        func validate(string: String, pattern: String) -> Bool {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            return predicate.evaluate(with: string)
        }
        
        guard let name = nameTextField.text, !name.isEmpty,
            validate(string: name, pattern: Constants.Patterns.Name) else {
            warn(with: .incorrectName)
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty,
            validate(string: email, pattern: Constants.Patterns.Email) else {
            warn(with: .incorrectEmail)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty,
            validate(string: password, pattern: Constants.Patterns.Password) else {
            warn(with: .weakPassword)
            return
        }
        
        let parameters = [
            ParameterKeys.Name: name,
            ParameterKeys.Email: email,
            ParameterKeys.Password: password
        ]
        
        client.register(parameters: parameters) { [weak self] response in
            guard let response = response, response == .success else {
                warn(with: .unknownError)
                return
            }

            guard let this = self else {
                return
            }

            guard let vc = this.storyboard?.instantiateViewController(withIdentifier: UIStoryboard.CompleteRegister) else {
                return
            }

            this.present(vc, animated: true) {
                //this.dismiss(animated: false, completion: nil)
            }
        }
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }

    private func setUI(enabled: Bool) {
        signupButton.isEnabled = enabled
        signupButton.isHidden = !enabled
        cancelButton.isEnabled = enabled
        warningLabel.isHidden = !enabled
        indicator.isHidden = enabled
        nameTextField.isEnabled = enabled
        emailTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
    }

}
