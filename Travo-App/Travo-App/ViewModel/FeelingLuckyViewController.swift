//
//  FeelingLuckyViewController.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 18/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import UIKit

class FeelingLuckyViewController: UIViewController {
    
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func btnTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.6,delay: 0,options: [.repeat, .autoreverse],
                           animations: {
                            self.btn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.6) {
                                self.btn.transform = CGAffineTransform.identity
                            }
            })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.btn.layer.removeAllAnimations()
            print("goes to the next controller")
        }
       
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
}

}
