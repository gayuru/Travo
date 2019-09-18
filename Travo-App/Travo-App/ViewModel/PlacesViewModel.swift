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
    
    func getPopularity() -> [Place]{
        return placeModel.sortPopularity()
    }
 
    func getRecommended() -> [Place]{
        return placeModel.sortRecommended()
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
    

}
