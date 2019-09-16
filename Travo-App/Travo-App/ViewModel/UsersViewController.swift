//
//  UsersViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 14/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    // Login View
        // Text Fields
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    
        // Buttons
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private let usersViewModel:UsersViewModel = UsersViewModel.init()
    
    // Storyboard setup
    let storyBoard:UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if (usersViewModel.authenticate(email: emailTextField.text, password: passwordTextField.text)) {
            // forward to home -- Still broken
            let nextViewController:UIViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
}
