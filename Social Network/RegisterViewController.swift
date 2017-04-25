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
        
        func warn(with warning: String) {
            warningLabel.text = warning
            setUI(enabled: true)
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
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CompleteRegisterViewController") as! CompleteRegisterViewController
            self?.present(vc, animated: true, completion: {
                self?.dismiss(animated: false, completion: nil)
            })
        }
    }

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
