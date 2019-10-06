//
//  UsersViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
// Icon 8 Image Reference
// <a target="_blank" href="https://icons8.com/icons/set/fingerprint">Fingerprint</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
//

import UIKit
import SVProgressHUD
import LocalAuthentication

/*
 
 BEFORE
  The user opens the app
    Check if the user.count > 0
        if yes then trigger the face id
           not guide him to the sign up page
    Else
    FACE ID / Touch ID triggers
        if none is enrolled
            show the normal login screen without asking for the device password
        if both authentication passes
            slide the user into the home screen
        else
            just show the normal login for the email and password
*/
class UsersViewController: UIViewController, UITextFieldDelegate {
    
    // Login View
        // Text Fields
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    
    // Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private let usersViewModel:UsersViewModel = UsersViewModel.init()
    
    // Keychain Variables
    var passwordItems: [KeychainLoginModel] = []
    
    /// An authentication context stored at class scope so it's available for use during UI updates.
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let userTappedOtherThanKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("closeKeyboard")))
        view.addGestureRecognizer(userTappedOtherThanKeyboard)
        
        context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
    
    // LOGIN VIEW METHODS
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "SegueToHome") {
//            let homeViewController = segue.destination as! HomeViewController
//            homeViewController.loggedInUser = usersViewModel.getCurrentUser()
//        } else if (segue.identifier == "SegueToRegister") {
//            let registerUserViewController = segue.destination as! RegisterUserViewController
//            registerUserViewController.usersViewModel = self.usersViewModel
//        }
//    }
    
        //Delegates for closing keyboard on "return" keypress
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    // View Context Specific Functions
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        //faceid is implemented
        context = LAContext()

        context.localizedCancelTitle = "Enter Username/Password"
    
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Log in to your account"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason ) { success, error in
                if success {
                    sleep(1)
                    let loginAlert = UIAlertController(title: "Successfull Login", message: "Login Credentials correct", preferredStyle: UIAlertController.Style.alert)
                    loginAlert.addAction(UIAlertAction(title: "Hooray!!", style: UIAlertAction.Style.default, handler: nil))
                    self.present(loginAlert, animated: true, completion: nil)
                } else {
                    let notEnrolledAlert = UIAlertController(title: "Error", message: "No biometrics are enrolled.", preferredStyle: UIAlertController.Style.alert)
                    notEnrolledAlert.addAction(UIAlertAction(title: "Enter Username/Password", style: UIAlertAction.Style.default, handler: nil))
                    self.present(notEnrolledAlert, animated: true, completion: nil)
                    
                    print(error?.localizedDescription ?? "Failed to authenticate")
                }
            }
            
        } else {
            print( "Can't evaluate policy")
            
            // Fall back to a asking for username and password.
            // ...
        }
        
//        if (usersViewModel.authenticate(email: emailTextField.text, password: passwordTextField.text)) {
//            SVProgressHUD.show()
//            self.performSegue(withIdentifier: "SegueToHome", sender: self)
//            SVProgressHUD.dismiss()
//        } else {
//            let loginAlert = UIAlertController(title: "Incorrect Login", message: "Login Credentials incorrect", preferredStyle: UIAlertController.Style.alert)
//            loginAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
//            self.present(loginAlert, animated: true, completion: nil)
//        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "SegueToRegister", sender: self)
    }
    

}
