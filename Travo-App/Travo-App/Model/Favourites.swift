//
//  Favourites.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 21/8/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import UIKit

class Favourites {
    
    var featuredImageView:UIImage!
    var place:String
    var city:String
    var openTime:String
    var starRatingImg:UIImage!
    var starRating:String
    
    init(featuredImageView:UIImage, place:String, city:String,openTime:String, starRatingImg:UIImage,starRating:String) {
        self.featuredImageView = featuredImageView
        self.place = place
        self.city = city
        self.openTime = openTime
        self.starRatingImg = starRatingImg
        self.starRating = starRating
    }
    
    static func fetchFavourites() -> [Favourites]
    {
        return [
            Favourites(featuredImageView: UIImage.init(named: "eiffel-tower")!, place: "Botanical Gardens", city: "Melbourne", openTime: "5:00AM - 8:00PM", starRatingImg:UIImage.init(named: "star (2)")!, starRating: "4.5"),
            Favourites(featuredImageView: UIImage.init(named: "eiffel-tower")!, place: "Eiffel Tower", city: "Sydney", openTime: "5:00AM - 8:00PM", starRatingImg:UIImage.init(named: "star (2)")!, starRating: "4.5"),
            Favourites(featuredImageView: UIImage.init(named: "eiffel-tower")!, place: "Federation Square", city: "Perth", openTime: "5:00AM - 8:00PM", starRatingImg:UIImage.init(named: "star (2)")!, starRating: "4.5"),
            Favourites(featuredImageView: UIImage.init(named: "eiffel-tower")!, place: "Eiffel Tower", city: "Cairns", openTime: "5:00AM - 8:00PM", starRatingImg:UIImage.init(named: "star (2)")!, starRating: "4.5"),
            Favourites(featuredImageView: UIImage.init(named: "eiffel-tower")!, place: "Art Gallery", city: "Melbourne", openTime: "5:00AM - 8:00PM", starRatingImg:UIImage.init(named: "star (2)")!, starRating: "4.5")
        ]
    }
}
