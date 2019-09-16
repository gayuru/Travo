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
    
    // Preferrable to use segue, but this gives greater flexibility
    @IBAction func loginButtonClicked(_ sender: Any) {
        if (usersViewModel.authenticate(email: emailTextField.text, password: passwordTextField.text)) {
            // Already Exists if the above passes
            let loggedInUser:User? = usersViewModel.getCurrentUser()
            // TODO would prefer to avoid this forced cast
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
            nextViewController.loggedInUser = loggedInUser!
            self.present(nextViewController, animated:true, completion:nil)
        } else {
            let loginAlert = UIAlertController(title: "Incorrect Login", message: "Login Credentials incorrect", preferredStyle: UIAlertController.Style.alert)
            loginAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
            self.present(loginAlert, animated: true, completion: nil)
        }
    }
    
}
