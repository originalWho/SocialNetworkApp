import UIKit

class LoginViewController: UIViewController {

    // MARK: - Typealiases
    fileprivate typealias OAuth = SocialNetworkClient.OAuth
    fileprivate typealias ParameterKeys = SocialNetworkClient.ParameterKeys

    // MARK: - Outlets

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
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
        setUI(enabled: false)
        
        func warn(with warning: WarningMessage) {
            warningLabel.text = warning.rawValue
            setUI(enabled: true)
        }
        
        func validate(string: String, pattern: String) -> Bool {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            return predicate.evaluate(with: string)
        }
        
        guard let email = emailTextField.text, !email.isEmpty,
            validate(string: email, pattern: Constants.Patterns.Email) else {
            warn(with: .incorrectEmail)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty,
            validate(string: password, pattern: Constants.Patterns.Password) else {
            warn(with: .incorrectPassword)
            return
        }
        
        let parameters = [
            OAuth.ParameterKeys.GrantType: OAuth.GrantType.password,
            ParameterKeys.Email: email,
            ParameterKeys.Password: password
        ] as [String : Any]
        
        client.authenticate(parameters: parameters) { [weak self] response in
            guard let response = response, response == .success else {
                warn(with: .unknownError)
                return
            }

            let viewController = self?.storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Main)
            let window = (UIApplication.shared.delegate as! AppDelegate).window
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()

            viewController?.view.alpha = 0
            UIView.animate(withDuration: 0.2) { viewController?.view.alpha = 1 }
        }
    }

    @IBAction func register(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Register) else {
            return
        }

        present(vc, animated: true)
    }

    private func setUI(enabled: Bool) {
        warningLabel.isHidden = !enabled
        signinButton.isEnabled = enabled
        signinButton.isHidden = !enabled
        registerButton.isEnabled = enabled
        indicator.isHidden = enabled
    }

}
