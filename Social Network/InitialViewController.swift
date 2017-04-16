import UIKit

class InitialViewController: UIViewController {

    // MARK: - Typealiases

    fileprivate typealias OAuth = SocialNetworkClient.OAuth

    // MARK: - Private properties

    fileprivate let client = SocialNetworkClient.default

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - Actions

extension InitialViewController {

    @IBAction func continueWithFacebook(_ sender: Any) {
        let parameters = [
            OAuth.ParameterKeys.GrantType: OAuth.GrantType.Code,
            OAuth.ParameterKeys.Service: OAuth.Service.Facebook
        ] as [String : Any]

        client.authenticate(parameters: parameters) { response in
            // TODO: Proceed
        }
    }

    @IBAction func continueWithGoogle(_ sender: Any) {
        let parameters = [
            OAuth.ParameterKeys.GrantType: OAuth.GrantType.Code,
            OAuth.ParameterKeys.Service: OAuth.Service.Google
        ] as [String : Any]

        client.authenticate(parameters: parameters) { response in
            // TODO: Proceed
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        // TODO: Present RegisterViewController
    }
    
    @IBAction func signin(_ sender: Any) {
        // TODO: Present LoginViewController
    }
    
}
