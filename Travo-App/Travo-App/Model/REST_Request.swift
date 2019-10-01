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
    
    private let googleAPIKey:String = "AIzaSyA7xBUMv8Xz9EIXgcASqicj0H92DM3rd9Q"
    private let base_url:String = "https://maps.googleapis.com/maps/api/place/nearbysearch/"
    private let paramLocation:String = "json?location="
    private let latlngSeparator:String = ","
    private let paramSeparator:String = "&"
    private let defaultRadius:String = "radius=1500"
    private let paramType:String = "type="
    private let paramAPIKEY:String = "key="
    
    
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
        
        let params1 = [
            "client_id" : clientID,
            "client_secret" : clientSecret,
            "v":"20191001",
            "ll": "\(lat),\(lng)",
            "radius": "1000",
            "limit":10,
        ] as [String:Any]
        
     //getPlaceData(trendingVenue, parameters: parameters)
       // getTrendingVenues(trendingVenue, paramaters: params1)
    }
    
    func getPlaceData(_ endpoint:String, parameters:Parameters){
        var parsedResult : JSON!
        Alamofire.request(endpoint,method: .get,parameters: parameters).responseJSON { (response) in
            if(response.result.isSuccess){
                switch response.result{
                case .success(let value):
//                    let json = JSON(value)
//                    parsedResult = json["response"]["groups"][0]["items"]["venue"]["id"]
//                    print(json)
                    let json = JSON(value)
                    let items = json["response"]["groups"][0]["items"]
                    if (items.count > 0){
                        for result in items{
                            if let name = result.1["venue"]["name"].string{
                                print(name)
                                self.parseData(json: parsedResult)
                            }
                        }
                    }
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
    
    
    
    
//    func getTrendingVenues(_ endpoint:String,paramaters:Parameters){
//        var parsedResult : JSON!
//        Alamofire.request(endpoint,method: .get,parameters: paramaters).responseJSON { (response) in
//            if(response.result.isSuccess){
//                switch response.result{
//                case .success(let value):
//                    let json = JSON(value)
//                    print(json)
//                case .failure(let error):
//                    print(error)
//                }
//
//            }
//        }
//    }
    
    
    func parseData(json:JSON){
//        if json.count > 0{
//            for (_,result) in json{
////                let place = Place(name: <#T##String#>, desc: <#T##String#>, location: <#T##String#>, address: <#T##String#>, imageURL: <#T##String#>, openTime: <#T##String#>, starRating: <#T##Double#>, popularityScale: <#T##Int#>, weatherCondition: <#T##Int#>, categoryBelonging: <#T##[String]#>)
////                let name = result["venue"]["name"]
////                let desc = result["venue"]
//            }
//        }
    }
    
}








