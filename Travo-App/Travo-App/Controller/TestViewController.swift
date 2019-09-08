//
//  TestViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var placesButton: UIButton!
    @IBOutlet var sunsetButton: UIButton!
    @IBOutlet var hillButton: UIButton!
    @IBOutlet var cyclingButton: UIButton!
    @IBOutlet var bottomNav: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placesButton.imageView?.contentMode = .scaleAspectFit
        sunsetButton.imageView?.contentMode = .scaleAspectFit
        hillButton.imageView?.contentMode = .scaleAspectFit
        cyclingButton.imageView?.contentMode = .scaleAspectFit
        bottomNav.layer.cornerRadius = 10
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
