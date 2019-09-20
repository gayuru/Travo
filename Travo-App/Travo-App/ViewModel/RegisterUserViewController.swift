//
//  RegisterUserViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 17/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageUpload: UIButton!
    
    var usersViewModel:UsersViewModel?
    var allowedLogin:Bool = false
    
    @IBOutlet weak var nameTextField: UnderlinedTextField!
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    @IBOutlet weak var faceIDCheckbox: CheckboxButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fingerPress: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("closeKeyboard")))
        view.addGestureRecognizer(fingerPress)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // Segue Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueToHome") {
            let homeViewController = segue.destination as! HomeViewController
            // Segue will not be triggered unless the usersViewModel is not nil
            homeViewController.loggedInUser = usersViewModel!.getCurrentUser()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "SegueToHome") {
            if  allowedLogin == false {
                return false
            }
        }
        return true
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
    
    // REGISTER VIEW METHODS
    @IBAction func registerSignUpButtonClicked(_ sender: Any) {
        if let presentUsersViewModel = usersViewModel {
            let validRegistration:Bool = presentUsersViewModel.createUser(username: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, aboutMeDesc: "")
            if (validRegistration) {
                allowedLogin = true
                self.shouldPerformSegue(withIdentifier: "SegueToHome", sender: self)
            } else {
                let loginAlert = UIAlertController(title: "Missing Details", message: "Some registration details are missing", preferredStyle: UIAlertController.Style.alert)
                loginAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                self.present(loginAlert, animated: true, completion: nil)
                return
            }
        }
    }
}
