import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Typealiases
    
    private typealias OAuth = ClientConstants.OAuth
    private typealias ParameterKeys = ClientConstants.ParameterKeys

    // MARK: - Outlets

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signinButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var warningLabel: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

    // MARK: - Private properties

    fileprivate let client = SocialNetworkClient.default

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
    }

    // MARK: - IBActions

    @IBAction private func signIn(_ sender: Any) {
        setUI(enabled: false)
        
        func warn(with warning: WarningMessage) {
            warningLabel.text = warning.rawValue
            setUI(enabled: true)
        }
        
        func validate(string: String, pattern: ValidationPattern) -> Bool {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern.rawValue)
            return predicate.evaluate(with: string)
        }
        
        guard let email = emailTextField.text, !email.isEmpty,
            validate(string: email, pattern: .email) else {
            warn(with: .incorrectEmail)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty,
            validate(string: password, pattern: .password) else {
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

    @IBAction private func register(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UIStoryboard.Register) else {
            return
        }

        present(vc, animated: true)
    }

    private func setUI(enabled: Bool) {
        DispatchQueue.main.async {
            self.warningLabel.isHidden = !enabled
            self.signinButton.isEnabled = enabled
            self.signinButton.isHidden = !enabled
            self.registerButton.isEnabled = enabled
            self.indicator.isHidden = enabled
        }
    }

}
