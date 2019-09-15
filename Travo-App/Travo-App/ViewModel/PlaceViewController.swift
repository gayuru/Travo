//
//  PlaceViewController.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 15/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import UIKit

class PlaceViewController: UIViewController {
    
    //this is how you should pass the data into the controller
//    detailViewController.contact = contacts[index]
    
    
    @IBAction func visitButton(_ sender: Any) {
        //head to google maps app
    }
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var placeOpenHours: UILabel!
    @IBOutlet weak var placeRating: UILabel!
    
    var index:Int?
    
    var viewModel = PlacesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        index = 2;
        placeImage.contentMode = .scaleToFill
        placeTitle.text = viewModel.getTitleFor(index: index!)
        placeDescription.text = viewModel.getDescFor(index: index!)
        placeOpenHours.text = viewModel.getOpenTimeFor(index: index!)
        placeRating.text = String(viewModel.getStarRating(index: index!))
        placeImage.image = viewModel.getImageURLFor(index: index!)
    }
    
}

