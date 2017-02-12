//
//  RegisterViewController.swift
//  Social Network
//
//  Created by Arthur Davletshin on 2/12/17.
//  Copyright © 2017 hse. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    let client = SocialNetworkClient.shared()
    
    struct WarningMessage {
        static let incorrectName = "Incorrect name"
        static let incorrectEmail = "Incorrect E-mail"
        static let weakPassword = "Password is too weak"
    }
    
    struct Patterns {
        static let name = "[A-Za-z]{2,20}"
        static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let password = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(_ sender: Any) {
        signupButton.isEnabled = false
        warningLabel.isHidden = true
        
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        func warn(with: String) {
            signupButton.isEnabled = true
            warningLabel.isHidden = false
            warningLabel.text = with
        }
        
        func validate(string: String, pattern: String) -> Bool {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            return predicate.evaluate(with: string)
        }
        
        guard !name.isEmpty, validate(string: name, pattern: Patterns.name) else {
            warn(with: WarningMessage.incorrectName)
            return
        }
        
        guard !email.isEmpty, validate(string: email, pattern: Patterns.email) else {
            warn(with: WarningMessage.incorrectEmail)
            return
        }
        
        //Validate password
        guard !password.isEmpty, validate(string: password, pattern: Patterns.password) else {
            warn(with: WarningMessage.weakPassword)
            return
        }
        
        let parameters = [
            SocialNetworkClient.ParameterKeys.Name: name,
            SocialNetworkClient.ParameterKeys.Email: email,
            SocialNetworkClient.ParameterKeys.Password: password
        ]
        
        client.register(parameters: parameters as [String : AnyObject]) { (result, error) in
            
        }
    }
}
