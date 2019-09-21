//
//  RegisterUserViewController.swift
//  Travo-App
//
//  Created by Jun Cheong on 17/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var imageUpload: UIButton!
    
    var usersViewModel:UsersViewModel?
    var allowedLogin:Bool = false
    
    @IBOutlet weak var nameTextField: UnderlinedTextField!
    @IBOutlet weak var emailTextField: UnderlinedTextField!
    @IBOutlet weak var passwordTextField: UnderlinedTextField!
    @IBOutlet weak var faceIDCheckbox: CheckboxButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var nameHintPopoverButton: UIButton!
    @IBOutlet weak var emailHintPopoverButton: UIButton!
    @IBOutlet weak var passwordHintPopoverButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fingerPress: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("closeKeyboard")))
        view.addGestureRecognizer(fingerPress)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameHintPopoverButton.addTarget(self, action: #selector(tappedNameHint), for: .touchUpInside)
        emailHintPopoverButton.addTarget(self, action: #selector(tappedEmailHint), for: .touchUpInside)
        passwordHintPopoverButton.addTarget(self, action: #selector(tappedPasswordHint), for: .touchUpInside)
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
    
        // HINT POPOVER METHODS
    @IBAction func nameHintPopoverButtonClicked(_ sender: Any) {
    }
    @IBAction func emailHintPopoverButtonClicked(_ sender: Any) {
    }
    @IBAction func passwordHintPopoverButtonClicked(_ sender: Any) {
    }
    
    @objc
    private func tappedNameHint() {
        
        guard let popoverNameViewController = storyboard?.instantiateViewController(withIdentifier: "popoverNameHintViewController") else { return }
        popoverNameViewController.modalPresentationStyle = .popover
        let popOverVC = popoverNameViewController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.nameHintPopoverButton
        popOverVC?.sourceRect = CGRect(x: self.nameHintPopoverButton.bounds.midX, y: self.nameHintPopoverButton.bounds.minY, width: 0, height: 0)
        popoverNameViewController.preferredContentSize = CGSize(width: 235, height: 77)
        self.present(popoverNameViewController, animated: true)
    }
    
    @objc
    private func tappedEmailHint() {
        
        guard let popoverNameViewController = storyboard?.instantiateViewController(withIdentifier: "popoverEmailHintViewController") else { return }
        popoverNameViewController.modalPresentationStyle = .popover
        let popOverVC = popoverNameViewController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.emailHintPopoverButton
        popOverVC?.sourceRect = CGRect(x: self.emailHintPopoverButton.bounds.midX, y: self.nameHintPopoverButton.bounds.minY, width: 0, height: 0)
        popoverNameViewController.preferredContentSize = CGSize(width: 238, height: 77)
        self.present(popoverNameViewController, animated: true)
    }
    
    @objc
    private func tappedPasswordHint() {
        
        guard let popoverNameViewController = storyboard?.instantiateViewController(withIdentifier: "popoverPasswordHintViewController") else { return }
        popoverNameViewController.modalPresentationStyle = .popover
        let popOverVC = popoverNameViewController.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.passwordHintPopoverButton
        popOverVC?.sourceRect = CGRect(x: self.passwordHintPopoverButton.bounds.midX, y: self.nameHintPopoverButton.bounds.minY, width: 0, height: 0)
        popoverNameViewController.preferredContentSize = CGSize(width: 235, height: 160)
        self.present(popoverNameViewController, animated: true)
    }
    
    // Ignore the default IOS Presentation Style
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    // Changes brightness of view when popover is tapped
    func setPopoverBackgroundViewBrightness(alpha: CGFloat) {
        let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
        UIView.animate(withDuration: 0.2) {
            statusBarWindow?.alpha = alpha;
            self.view.alpha = alpha;
            self.navigationController?.navigationBar.alpha = alpha;
        }
    }
    
    // Brightness of View returns to normal when Popover exits
    func popoverPresentationControllerDidDismissPopover(_ popOverViewController: UIPopoverPresentationController) {
        setPopoverBackgroundViewBrightness(alpha: 1)
    }
    
    // Brightness of View decreases when Popover entered
    func prepareForPopoverPresentation(_ popOverViewController: UIPopoverPresentationController) {
        setPopoverBackgroundViewBrightness(alpha: 0.3)
    }
}
