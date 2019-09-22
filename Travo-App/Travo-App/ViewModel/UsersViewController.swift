//
//  UsersViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit
import SVProgressHUD
class UsersViewController: UIViewController, UITextFieldDelegate {
    
    // Login View
        // Text Fields
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    
    // Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private let usersViewModel:UsersViewModel = UsersViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let userTappedOtherThanKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("closeKeyboard")))
        view.addGestureRecognizer(userTappedOtherThanKeyboard)
    }
    
    // LOGIN VIEW METHODS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueToHome") {
            let homeViewController = segue.destination as! HomeViewController
            homeViewController.loggedInUser = usersViewModel.getCurrentUser()
        } else if (segue.identifier == "SegueToRegister") {
            let registerUserViewController = segue.destination as! RegisterUserViewController
            registerUserViewController.usersViewModel = self.usersViewModel
        }
    }
    
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
        
        if (usersViewModel.authenticate(email: emailTextField.text, password: passwordTextField.text)) {
            SVProgressHUD.show()
            self.performSegue(withIdentifier: "SegueToHome", sender: self)
            SVProgressHUD.dismiss()
        } else {
            let loginAlert = UIAlertController(title: "Incorrect Login", message: "Login Credentials incorrect", preferredStyle: UIAlertController.Style.alert)
            loginAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
            self.present(loginAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "SegueToRegister", sender: self)
    }
    

}
