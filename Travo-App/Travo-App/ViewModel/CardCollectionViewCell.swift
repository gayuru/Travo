//
//  CardCollectionViewCell.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 21/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var cityLabel:UILabel!
    @IBOutlet weak var openTimeLabel:UILabel!
    @IBOutlet weak var starRating:UIImageView!
    @IBOutlet weak var startRatingLabel:UILabel!
    
    
    var favourites: Favourites? {
        didSet{
            self.updateUI()
        }
    }
    
    private func updateUI(){
        
        if let favourites = favourites {
            featuredImageView.image = favourites.featuredImageView
            cityLabel.text = favourites.city
            openTimeLabel.text = favourites.openTime
            starRating.image = favourites.starRatingImg
            startRatingLabel.text = favourites.starRating
        }else{
            featuredImageView.image = nil
            placeLabel.text = nil
            cityLabel.text = nil
            openTimeLabel.text = nil
            starRating.image = nil
            startRatingLabel.text = nil
        }
    }
    
}
