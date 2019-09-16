//
//  ProfileViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 16/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileBackground.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        print("Test")
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
