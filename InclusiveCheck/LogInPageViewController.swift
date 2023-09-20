//
//  LogInPageViewController.swift
//  InclusiveCheck
//
//  Created by Isha Nagireddy on 9/18/23.
//

import UIKit
import Firebase
import FirebaseAuth


class LogInPageViewController: UIViewController {
    
    // ui variables
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // save the name of user in variable
    static var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        // get email and password data from the text boxes
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        
        // Signing in with firebase: https://medium.com/firebase-developers/ios-firebase-authentication-sdk-email-and-password-login-6a3bb27e0536
        Auth.auth().signIn(withEmail: email, password: password, completion: { (auth, error) in
            
            //if there was an error, handle it
            if let maybeError = error {
                let err = maybeError as NSError
                switch err.code {
                
                // if wrong password is entered
                case AuthErrorCode.wrongPassword.rawValue:
                    print("wrong password")
                    let dialogMessage = UIAlertController(title: "Incorrect Password", message: "Please try entering your password again.", preferredStyle: .alert)
                
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                
                // if invalid email address was entered
                case AuthErrorCode.invalidEmail.rawValue:
                    print("invalid email")
                    let dialogMessage = UIAlertController(title: "Invalid Email", message: "An invalid email was typed in. Please try inputting your email again.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                    
                // if account with different credentials exists
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    print("accountExistsWithDifferentCredential")
                    let dialogMessage = UIAlertController(title: "Account with Different Credentials", message: "This account exists, but with different credentials. Please try again.", preferredStyle: .alert)

                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                
                // if there are any other errors that were not covered by the previous statements
                default:
                    print("unknown error: \(err.localizedDescription)")
                    var dialogMessage = UIAlertController(title: "User was not authenticated", message: "Please try again.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                }
            }
            
            //there was no error so the user could be auth'd or maybe not
            else {
                
                // if user auth'd set name and transition to next page
                if let user = auth?.user {
                    print("user is authd")
                    LogInPageViewController.name = user.email!
                    self.performSegue(withIdentifier: "toAccountHome", sender: nil)
                }
                
                // else send alert
                else {
                    print("no authd user")
                    var dialogMessage = UIAlertController(title: "User was not authenticated", message: "Please try again.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                }
            }
        })
    }
}
