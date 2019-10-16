//
//  RestRequest.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 15/10/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol Refresh {
    func updateUI()
}

class RestRequest {
    
    private var _places:[Place]=[]
    var delegate:Refresh?
    //Foursquare API
    //make constants later
//    private let clientID:String = "TZVHFQG3SMODPGCALX3SL1AORYSFXGO05UGP0IENVEI1EW2T"
//    private let clientSecret:String = "VWL3NGD0EZOAUYYDGOT4J5FABPEGVWUKPK5B5E3UOWQEHAQG"
    private let clientID:String = "AEQUPDDCAKT4LFIQBI2K1EZXOEB4QPJUGMTASCBRNIZWFE2A"
    private let clientSecret:String = "VJ5OX10OMWPHOGDYV11Q40EIPGKZF54MDMNPHXAHOXWRFPZL"
    private let recommendedEndPoint:String = "https://api.foursquare.com/v2/venues/explore"
    private let detailPlaceEndPoint:String = "https://api.foursquare.com/v2/venues/"
    
    //Weather API
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "63629684ee2d8bbc99dde8055cd35d19"
    
    var count:Int = 0
    var numPlaces = 10
    var weather:Int = 0;
    
    var places:[Place]{
        return _places
    }
    
    //access the places from the foursquare api
    func getFSPlaces(lat:String,lng:String,category:String){
        _places = []
        let parameters = [
            "client_id": clientID,
            "client_secret" : clientSecret,
            "v":"20191003",
            "ll": "\(lat),\(lng)",
            "radius": "10000",
            "section":category,
            "limit":self.numPlaces,
            ] as [String : Any]
        getPlaceData(recommendedEndPoint, parameters: parameters)
    }
    
    func getPlaceData(_ endpoint:String,parameters:Parameters){
        Alamofire.request(endpoint,method: .get,parameters: parameters).responseJSON { (response) in
            if(response.result.isSuccess){
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.parseData(json:json)
                case .failure(let error):
                    print(error)
                }
            }else{
                print("Error: \(String(describing: response.result.error))")
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
        Alamofire.request(detailEndPoint,method: .get,parameters: placeParamater)
            .responseJSON { (response) in
                if(response.result.isSuccess){
                    switch response.result{
                    case .success(let value):
                        let json = JSON(value)
                        let place = json["response"]["venue"]
                        let placeLat = place["location"]["lat"].doubleValue
                        let placeLng = place["location"]["lng"].doubleValue
                        let placeObject = self.getPlaceObject(p: place)
                        self.getWeatherParam(lat: String(placeLat), lng: String(placeLng))
                        self.updatePlaceArr(place: placeObject, weather: self.weather)
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
        
        let placeObj = Place(name: placeName, desc: desc, location: location, address: address, imageURL: imageURL, openTime: openTime, starRating: rating, popularityScale: 9, weatherCondition: 0, categoryBelonging: ["general"])
        
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
    }
    
    //populate the places array with the places with correct info
    func updatePlaceArr(place:Place,weather:Int){
        var tempPlace = place
        tempPlace.weatherCondition = weather
        self._places.append(tempPlace)
        //keeps track of the number of places added
        self.count += 1
        //checks if all the places are added so the arraay to notify the view
        
        if(self.count == self.numPlaces){
            if let del = self.delegate{
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
            }
        }
    }
    
    //access weather data of a place
    func getWeatherParam(lat:String,lng:String){
        let params = [
            "lat":lat,
            "lon":lng,
            "appid":APP_ID
            ] as [String:Any]
        
        self.getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    //API request for the weather data of a place
    func getWeatherData(url:String, parameters:Parameters) {
        Alamofire.request(url,method:.get,parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                if json["main"]["temp"].double != nil {
                    let weatherID = json["weather"][0]["id"].intValue
                    self.weather = weatherID
                }else{
                    print("Weather not available")
                }
            }else{
                print("Weather request failed!")
            }
        }
    }
    
    func sortPopularity(category:String) -> [Place]{
        return self._places.sorted(by: { $0.starRating > $1.starRating })
    }

//    private func getListOfPlacesChosenByCategory(_ category:String)->[Place]{
//        var chosenPlaces = [Place]()
//        for place in places {
//            if (place.categoryBelonging.contains(category)) {
//                chosenPlaces.append(place)
//            }
//        }
//        return chosenPlaces
//    }
    
    private init(){
        getFSPlaces(lat: "-37.814", lng: "144.96332", category: "pizza")
    }
    static let shared = RestRequest()
}
