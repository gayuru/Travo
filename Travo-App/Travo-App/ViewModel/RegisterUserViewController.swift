//
//  RegisterUserViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 17/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController {
    
    @IBOutlet weak var imageUpload: UIButton!
    
    var usersViewModel:UsersViewModel?
    
    @IBOutlet weak var nameTextField: UnderlinedTextField!
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    @IBOutlet weak var faceIDCheckbox: CheckboxButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "SegueToHome") {
            let homeViewController = segue.destination as! HomeViewController
            // Segue will not be triggered unless the usersViewModel is not nil
            homeViewController.loggedInUser = usersViewModel!.getCurrentUser()
        }
    }
    
    // REGISTER VIEW METHODS
    @IBAction func registerSignUpButtonClicked(_ sender: Any) {
        if (usersViewModel != nil) {
            guard let name = nameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text else {
                    let loginAlert = UIAlertController(title: "Missing Details", message: "Some registration details are missing", preferredStyle: UIAlertController.Style.alert)
                    loginAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: nil))
                    self.present(loginAlert, animated: true, completion: nil)
                    return
            }
            
            if (usersViewModel!.createUser(username: name, email: email, password: password, aboutMeDesc: "")) {
                self.performSegue(withIdentifier: "SegueToHome", sender: self)
            } else {
                let loginAlert = UIAlertController(title: "Failed To Create Account", message: "Something went wrong creating your account", preferredStyle: UIAlertController.Style.alert)
                loginAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(loginAlert, animated: true, completion: nil)
            }
        }
    }
}
