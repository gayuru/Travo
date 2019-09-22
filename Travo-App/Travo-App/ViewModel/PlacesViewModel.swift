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
    
    private let placeModel = Places()
    private var weatherModel = Weather()
    
    var places:[Place]{
        return placeModel.places
    }
    
    var count:Int{
    return places.count
    }
    
    func getPopularity(category:String) -> [Place]{
        return placeModel.sortPopularity(category: category)
    }
 
    func getRecommended(category:String) -> [Place]{
        return placeModel.sortRecommended(category: category)
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
    
    func getWeather(index:Int) -> UIImage?{
        let weatherCondition = places[index].weatherCondition
        let iconName = weatherModel.updateWeatherIcon(condition: weatherCondition)
        return UIImage.init(named: iconName)
    }
    
    func feltLucky() -> Int{
        let randomNumber = Int.random(in: 0..<places.count)
        return randomNumber
    }

    //better way to do this //put guard let statement for this 
    func getIndex(title:String) -> Int{
        let index = places.firstIndex { (Place) -> Bool in
            Place.name == title
        }!
        return index
    }
    
    func getPlace(index:Int) -> Place{
        return places[index]
    }

}
