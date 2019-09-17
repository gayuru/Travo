//
//  RegisterViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 17/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var nameTextField: UnderlinedTextField!
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    @IBOutlet weak var FaceIDCheckbox: CheckboxButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var usersViewModel:UsersViewModel
    
    // Storyboard setup
    let storyBoard:UIStoryboard = UIStoryboard(name: "Register", bundle: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        guard let username = nameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text else {
                    let registerAlert = UIAlertController(title: "Error", message: "Missing Signup Details", preferredStyle: UIAlertController.Style.alert)
                    registerAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                    self.present(registerAlert, animated: true, completion: nil)
        }
        if (usersViewModel.createUser(username: username, email: email, password: password, aboutMeDesc: "")) {
            
        }
    }
    
}
