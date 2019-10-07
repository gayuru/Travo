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
    private let detailPlaceEndPoint:String = "https://api.foursquare.com/v2/venues/"
    
    //Weather API
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "63629684ee2d8bbc99dde8055cd35d19"
    
    var weather:Int = 0;
    
    var places:[Place]{
        return _places
    }
    
    func  getFSPlaces(lat:String,lng:String,category:String){
        _places = []
        
        let parameters = [
            "client_id": clientID,
            "client_secret" : clientSecret,
            "v":"20191003",
            "ll": "\(lat),\(lng)",
            "radius": "1000",
            "section":category,
            "limit":1,
            ] as [String : Any]
        
        getPlaceData(venueRecEndPoint, parameters: parameters)
    }
    
    
//    func getWeatherParam(lat:String,lng:String) -> Int?{
//
//        let params = [
//            "lat":lat,
//            "lon":lng,
//            "appid":APP_ID
//            ] as [String:Any]
//        print("Inside function weather")
//
//       self.getWeatherData(url: WEATHER_URL, parameters: params){
//        (value, error) in
//           self.weather = value
//        print("goes inside this and value is \(value)")
//        }
//
//        print("value of self.weather is \(self.weather)")
//        return self.weather
//    }
//
//    func getWeatherData(url:String, parameters:Parameters,completionHandler: @escaping (Int, NSError?) -> Void) {
//        Alamofire.request(url,method:.get,parameters: parameters).responseJSON { (response) in
//            if response.result.isSuccess {
//                let json : JSON = JSON(response.result.value!)
//                if json["main"]["temp"].double != nil {
//                    let weatherID = json["weather"][0]["id"].intValue
//                    self.weather = weatherID
//                    //completionHandler(weatherID,response.error as NSError?)
//                }else{
//                    print("Weather not available")
//                }
//            }else{
//                print("Weather request failed!")
//            }
//        }
//    }
    
    func getWeatherParam(lat:String,lng:String){
        
        let params = [
            "lat":lat,
            "lon":lng,
            "appid":APP_ID
            ] as [String:Any]
        print("Inside function weather")
        
        self.getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    func getWeatherData(url:String, parameters:Parameters) {
        Alamofire.request(url,method:.get,parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                if json["main"]["temp"].double != nil {
                    let weatherID = json["weather"][0]["id"].intValue
                    self.weather = weatherID
                    //completionHandler(weatherID,response.error as NSError?)
                }else{
                    print("Weather not available")
                }
            }else{
                print("Weather request failed!")
            }
        }
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
    
    func parseData(json:JSON){
        if json.count > 0 {
            let result = json["response"]["groups"][0]["items"]
            for (_,v) in result{
                let venue = v["venue"]
                let venueID = venue["id"].string!
                getPlaceDetails(venueID: venueID)
                //  _places.append(place)
            }
        }
    }
    
    
    func getPlaceDetails(venueID:String){
        
        let placeParamater = [
            "client_id": clientID,
            "client_secret" : clientSecret,
            "v":"20191003",
            ] as [String : Any]
        
        let detailEndPoint = detailPlaceEndPoint+venueID
        
        Alamofire.request(detailEndPoint,method: .get,parameters: placeParamater).responseJSON { (response) in
            if(response.result.isSuccess){
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let place = json["response"]["venue"]
                    
                    let placeObject = self.getPlaceObject(p: place)
                    
                    //dump(placeObject)
                    //adds to the place array
                    
                case .failure(let err):
                    print(err)
                }
            }else{
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    //returns a place object after checking validity of data
    func getPlaceObject(p:JSON) -> Place{
        
        let placeName = p["name"].string ?? "Place name"
        let desc = p["description"].string ?? "No available description"
        let location = p["location"]["city"].string!
        let address = p["location"]["address"].string ?? "Address not found"
        let imageURL = getImageURL(photoObj: p["bestPhoto"])!
        let openTime = p["popular"]["timeframes"][0]["open"][0]["renderedTime"].string ?? "--"
        let tempRating = p["rating"].double!
        let rating = convertRating(rating: tempRating)
        
        let placeLat = p["location"]["lat"].doubleValue
        let placeLng = p["location"]["lng"].doubleValue
       // print("\(placeLat) , \(placeLng)")
        
        self.getWeatherParam(lat: String(placeLat), lng: String(placeLng))
        print(self.weather)
        let placeObj = Place(name: placeName, desc: desc, location: location, address: address, imageURL: imageURL, openTime: openTime, starRating: rating, popularityScale: 9, weatherCondition: 33, categoryBelonging: [",",","])
        
        return placeObj
    }
    
    //converts the rating which is out 10 to 5
    func convertRating(rating:Double) -> Double{
        return (rating/2)
    }
    
    func getImageURL(photoObj:JSON) -> String?{
        
        guard let imagePrefix = photoObj["prefix"].string else{
            return nil
        }
        guard let imageSuffix = photoObj["suffix"].string else{
            return nil
        }
        
        let url = imagePrefix + "original" + imageSuffix
        
        guard let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)else{
            return nil
        }
        
        
        return escapedAddress
        //        if let finalURL = URL(string: escapedAddress){
        //            return finalURL
        //        }
        
    }
    
    
}
