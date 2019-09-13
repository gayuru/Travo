//
//  PlacesViewModel.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 13/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import UIKit

struct PlacesViewModel{
    
    private var model = Places()
    
    var places:[Place]{
        return model.places
    }
    
    var count:Int{
    return places.count
    }
    
    func getTitleFor(index:Int) -> String{
        return places[index].name
    }
    
    func getDescFor(index:Int) -> String{
        return places[index].desc
    }
    
    func getLocationFor(index:Int) -> String{
        return places[index].location
    }
    
    func getaddressFor(index:Int) -> String{
        return places[index].address
    }
    
    func getImageURLFor(index:Int) -> UIImage?{
        return UIImage.init(named: places[index].imageURL)
    }
    
    func getOpenTimeFor(index:Int) -> String{
        return places[index].openTime
    }
    
    func getStarRating(index:Int) -> Double{
        return places[index].starRating
    }
}
