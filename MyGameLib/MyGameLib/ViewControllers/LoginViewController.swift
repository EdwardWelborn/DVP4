//
//  LoginViewController.swift
//  MyGameLib
//
//  Created by Roy Welborn on 1/17/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        backButton.image = UIImage(named: "backbutton") //Replaces title
        // backButton.setBackgroundImage(UIImage(named: "backbutton"), for: .normal, barMetrics: .default) // Stretches image

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        emailTextField.becomeFirstResponder()
        emailTextField.tag = 0
        passwordTextField.delegate = self
        passwordTextField.tag = 1
        loginButton.tag = 2
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.numberOfLines = 3
        errorLabel.text = ""
        errorLabel.alpha = 0
        setUpElements()
        passwordTextField.addTarget(passwordTextField, action: #selector(loginTapped), for: .editingDidEndOnExit)
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }

    
    func setUpElements() {
        
        // Style the elements
        StyleUtilities.styleTextField(emailTextField)
        StyleUtilities.styleTextField(passwordTextField)
        StyleUtilities.styleFilledButton(loginButton)
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate Text Fields
        errorLabel.text = ""
        errorLabel.alpha = 0
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        DispatchQueue.global().async {
            // Signing in the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    // Couldn't sign in
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else {
                    
                    let homeNavController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeNavController) as? UINavigationController
                    
                    self.view.window?.rootViewController = homeNavController
                    self.view.window?.makeKeyAndVisible()
                    // seque to homeview controller and send over user name
                    
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            loginButton.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let user = Auth.auth().currentUser {
            let userName: String = user.displayName!
            if let destination = segue.destination as? HomeViewController
            {
                destination.data = userName
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
