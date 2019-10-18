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
    
    private let placeModel = RestRequest.shared
    private var weatherModel = Weather()
    
    var delegate:Refresh?{
        get{
            return placeModel.delegate
        }
        set(value){
            placeModel.delegate = value
        }
    }
    
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
        let url = places[index].imageURL
        guard let imageUrl = URL(string:url) else{
            return showDefaultImage()
        }
        
        let data = try? Data(contentsOf: imageUrl)
        let image:UIImage? = nil
        if let imageData = data{
            return UIImage(data: imageData)
        }
        return image
    }
    
    func getImageURLFor(url:String) -> UIImage?{
        guard let imageUrl = URL(string:url) else{
            return showDefaultImage()
        }
        let data = try? Data(contentsOf: imageUrl)
        let image:UIImage? = nil
        if let imageData = data{
            return UIImage(data: imageData)
        }
        return image
    }
    
    func showDefaultImage() -> UIImage!{
        let image = UIImage(named:"default")
        return image
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
    
    func placeExistsByName(name:String)-> Bool{
        for place in places {
            if (place.name == name) {
                return true
            }
        }
        return false
    }
    
    func getIndex(title:String) -> Int{
        return places.firstIndex { (Place) -> Bool in
            Place.name == title
            }!
    }
    
    func getPlace(index:Int) -> Place{
        return places[index]
    }
    
}
