//
//  TestViewController.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 4/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var placesButton: UIButton!
    @IBOutlet var sunsetButton: UIButton!
    @IBOutlet var hillButton: UIButton!
    @IBOutlet var cyclingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button1.imageView?.contentMode = .scaleAspectFit
        placesButton.imageView?.contentMode = .scaleAspectFit
        sunsetButton.imageView?.contentMode = .scaleAspectFit
        hillButton.imageView?.contentMode = .scaleAspectFit
        cyclingButton.imageView?.contentMode = .scaleAspectFit
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
