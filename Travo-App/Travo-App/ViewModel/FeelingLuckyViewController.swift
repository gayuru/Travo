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
    
    let viewModel = PlacesViewModel()
    let placeVC = PlaceViewController()
    @IBOutlet weak var btn: UIButton!
    @IBOutlet var bottomNav: UIView!
    
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
        }
        
        if viewModel.feltLucky() != nil {
            performSegue(withIdentifier: "feltLucky", sender: self)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "feltLucky"){
            let secondController = segue.destination as! PlaceViewController
            secondController.indexPass = viewModel.getTitleFor(index: viewModel.feltLucky())
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomNav.layer.cornerRadius = 10
        bottomNav.layer.masksToBounds = true
    }
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    @IBAction func showLuckyView(segue:UIStoryboardSegue){}

}
