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

class RestRequest{
    
    private var _places:[Place]=[]
    private var _categoryPlaces:[Place]=[]
    var delegate:Refresh?
    //Foursquare API
    //make constants later
    private let clientID:String = "TZVHFQG3SMODPGCALX3SL1AORYSFXGO05UGP0IENVEI1EW2T"
    private let clientSecret:String = "VWL3NGD0EZOAUYYDGOT4J5FABPEGVWUKPK5B5E3UOWQEHAQG"
//
//    private let clientID:String = "2GFA3DH4LWHPGX0JKT3B0UL0HOFTKBHXDBNRD1A1TLBYYBBC"
//    private let clientSecret:String = "IWPJCKIB4J0JJ5OVYCXSO0G1ZQPK5CFZHFFD1VJKEKVCDGNS"
    
//    private let clientID:String = "AEQUPDDCAKT4LFIQBI2K1EZXOEB4QPJUGMTASCBRNIZWFE2A"
//    private let clientSecret:String = "VJ5OX10OMWPHOGDYV11Q40EIPGKZF54MDMNPHXAHOXWRFPZL"
    
//    private let clientID:String = "2AD05IB5KU4KQT2JWO5DTN0Z24S4RKOW3TKCE33TK0HD3ZWG"
//    private let clientSecret:String = "SKUFMM1BXLXA00EC4MCKLRLR4HTSPVATYRVWDCJEWKHOTZVR"

//    private let clientID:String = "OGSXUYYLFVXNYSRVORE4URWVUMX3MNRTHYHHKZ40XZONWTRF"
//    private let clientSecret:String = "UAA3AEVPZS0TOBR0AUSFX5LQTMIBM2UWKSRND4RHHO4HATKG"
    
//    private let clientID:String = "XY34X0LNUG14QZLTNDS4AMURQIJUI12EOSJDMLDOXK13OZGV"
//    private let clientSecret:String = "ISXKTZ5QLMWO4R4IC2UYOSNVNKBDCR5OSHGDE5VT12FF21VS"
//
    private let recommendedEndPoint:String = "https://api.foursquare.com/v2/venues/explore"
    private let detailPlaceEndPoint:String = "https://api.foursquare.com/v2/venues/"
    private let categoryEndPoint:String = "https://api.foursquare.com/v2/venues/search"
    
    //Weather API
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "63629684ee2d8bbc99dde8055cd35d19"
    
    var count:Int = 0
    var numPlaces = 10
    var weather:Int = 0;
    var apiCalls:Int = 0;
    var places:[Place]{
        return _places
    }
    var categoryPlaces : [Place]{
        return _categoryPlaces
    }
    var lat:String? = ""
    var lng:String? = ""

    init(lat:String,lng:String){
        self.updateLocation(lat: lat, lng: lng)
    }

    func updateLocation(lat:String,lng:String){
        self.lat = lat
        self.lng = lng
        
        if(lat == "" && lng == ""){
            print("nothing")
        }else{
            print("Getting locations of places which are in \(lat) & \(lng)")
            getFSPlaces(lat: lat, lng: lng, category: "bar")
        }
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
            "sortByDistance":1,
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
                        if json.count > 0 {
                            if json["meta"]["code"] == 429{
                               print("Quote Exceeded")
                            }
                            let place = json["response"]["venue"]
                            let placeLat = place["location"]["lat"].doubleValue
                            let placeLng = place["location"]["lng"].doubleValue
                            let placeObject = self.getPlaceObject(p: place)
                            self.getWeatherParam(lat: String(placeLat), lng: String(placeLng))
                            self.updatePlaceArr(place: placeObject, weather: self.weather)
                        }
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
        let location = p["location"]["city"].string ?? "Location unavailable"
        let address = p["location"]["address"].string ?? "Address not found"
        let imageURL = getImageURL(photoObj: p["bestPhoto"]) ?? "default"
        let openTime = p["popular"]["timeframes"][0]["open"][0]["renderedTime"].string ?? "--"
        let tempRating = p["rating"].double ?? 0.0
        let rating = convertRating(rating: tempRating)
        let category = p["categories"][0]["name"].string ?? ""
        
        let placeObj = Place(name: placeName, desc: desc, location: location, address: address, imageURL: imageURL, openTime: openTime, starRating: rating, weatherCondition: 0, categoryBelonging: [category])
        
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
        let tempPlace = place
        tempPlace.weatherCondition = weather
        self._places.append(tempPlace)
        //keeps track of the number of places added
        self.count += 1
        //checks if all the places are added so the arraay to notify the view
        
        if(self.count == self.numPlaces){
            if let del = self.delegate{
                DispatchQueue.main.async {
                    del.updateUI()
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

    //lists out the elements which are not in the first 6 of the popular list and by how close it is
    func sortRecommended() -> [Place]{
        let tempPlaces = self.sortPopularity(category: "")
        var recommendedPlaces:[Place] = []
        for p in self._places{
            if(!tempPlaces.prefix(2).contains(p)){
                recommendedPlaces.append(p)
            }
        }
        return recommendedPlaces
//        return tempPlaces
    }
}
