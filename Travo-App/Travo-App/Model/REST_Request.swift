//
//  REST_Request.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 26/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class REST_Request{
    
    private var _places:[Place]=[]
    
    //Foursquare API
    //make constants later
    private let clientID:String = "TZVHFQG3SMODPGCALX3SL1AORYSFXGO05UGP0IENVEI1EW2T"
    private let clientSecret:String = "VWL3NGD0EZOAUYYDGOT4J5FABPEGVWUKPK5B5E3UOWQEHAQG"
    private let venueRecEndPoint:String = "https://api.foursquare.com/v2/venues/explore"
    private let trendingVenue:String = "https://api.foursquare.com/v2/venues/trending"
    
    //Weather API
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "63629684ee2d8bbc99dde8055cd35d19"
    
    
    var places:[Place]{
        return _places
    }
    
    func getWeatherParam(lat:String,lng:String){
        let params = [
            "lat":lat,
            "lon":lng,
            "appid":APP_ID
            ] as [String:Any]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    func  getFSPlaces(lat:String,lng:String,category:String){
        _places = []
        
        let parameters = [
            "client_id": clientID,
            "client_secret" : clientSecret,
            "v":"20190927",
            "ll": "\(lat),\(lng)",
            "radius": "1000",
            "section":category,
            "limit":10,
            ] as [String : Any]
        
        getPlaceData(venueRecEndPoint, parameters: parameters)
        // getTrendingVenues(trendingVenue, paramaters: params1)
    }
    
    func getPlaceData(_ endpoint:String, parameters:Parameters){
        Alamofire.request(endpoint,method: .get,parameters: parameters).responseJSON { (response) in
            if(response.result.isSuccess){
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.parseData(json: json)
                case .failure(let err):
                    print(err)
                }
            }else{
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    func getWeatherData(url:String, parameters:Parameters){
        Alamofire.request(url,method:.get,parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
              print(weatherJSON)
            }else{
               
            }
        }
        
    }
    
    
    
    func parseData(json:JSON){
        if json.count > 0 {
            let result = json["response"]["groups"][0]["items"]
            print(result)
            for (_,v) in result{
                let venue = v["venue"]
                let placeName = venue["name"].string!
                let location = venue["location"]["address"].string!
                //                guard let image = v["venue"]["photos"]["icon"] else {return}
//                let prefix = venue["categories"][0]["icon"]["prefix"].string
//                let suffix = venue["categories"][0]["icon"]["suffix"].string
                let address = venue["location"]["address"].string!
                let category = venue["categories"][0]["name"].string!
//                let url = prefix! + suffix!
//                let icon = URL(string: (prefix! + suffix!))
                var place = Place(name: placeName, desc: "", location: location, address: address, imageURL: "", openTime: "", starRating: 4, popularityScale: 3, weatherCondition: 3, categoryBelonging: [category])
                _places.append(place)
                
            }
            
            
        }
    }
}
