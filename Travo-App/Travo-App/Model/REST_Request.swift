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

protocol RestRequestDelegate {
    func finishLoadingPlaces()
}

class REST_Request{
    
    private var _places:[Place]=[]
    
    var delegate:RestRequestDelegate?
    
    var count:Int = 0
    var numPlaces:Int = 10
    //Foursquare API
    //make constants later
    private let clientID:String = "MyClientId"
    private let clientSecret:String = "MyClientSecret"
    private let venueRecEndPoint:String = "https://api.foursquare.com/v2/venues/explore"
    private let detailPlaceEndPoint:String = "https://api.foursquare.com/v2/venues/"
    
    //Weather API
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "MyWeatherAppId"
    
    var weather:Int = 0;
    let group = DispatchGroup()
    
    var places:[Place]{
        return _places
    }
    
    init(){
        getFSPlaces(lat: "-37.814", lng: "144.96332", category: "pizza")
        //after this is done
    }

    //access the places from the foursquare api
    func getFSPlaces(lat:String,lng:String,category:String){
        _places = []
        let parameters = [
            "client_id": clientID,
            "client_secret" : clientSecret,
            "v":"20191003",
            "ll": "\(lat),\(lng)",
            "radius": "1000",
            "section":category,
            "limit":self.numPlaces,
            ] as [String : Any]
        getPlaceData(venueRecEndPoint, parameters: parameters)
    }
    
    //API request for the list of places
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
    
    //access the place details for the places list
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
    
    //API request for the details of the place
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
                    let placeLat = place["location"]["lat"].doubleValue
                    let placeLng = place["location"]["lng"].doubleValue
                    
                    let placeObject = self.getPlaceObject(p: place)
                    self.getWeatherParam(lat: String(placeLat), lng: String(placeLng))
                    self.group.notify(queue: .main) {
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
        let location = p["location"]["city"].string!
        let address = p["location"]["address"].string ?? "Address not found"
        let imageURL = getImageURL(photoObj: p["bestPhoto"])!
        let openTime = p["popular"]["timeframes"][0]["open"][0]["renderedTime"].string ?? "--"
        let tempRating = p["rating"].double!
        let rating = convertRating(rating: tempRating)
        
        let placeObj = Place(name: placeName, desc: desc, location: location, address: address, imageURL: imageURL, openTime: openTime, starRating: rating, popularityScale: 9, weatherCondition: 0, categoryBelonging: ["general"])
        
        return placeObj
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
            DispatchQueue.main.async {
                self.delegate?.finishLoadingPlaces()
            }
            self.delegate?.finishLoadingPlaces()
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
        group.enter()
        Alamofire.request(url,method:.get,parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value!)
                if json["main"]["temp"].double != nil {
                    let weatherID = json["weather"][0]["id"].intValue
                    self.weather = weatherID
                    self.group.leave()
                }else{
                    print("Weather not available")
                }
            }else{
                print("Weather request failed!")
            }
        }
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
    
    func sortPopularity(category:String) -> [Place]{
        return getListOfPlacesChosenByCategory(category).sorted(by: { $0.popularityScale > $1.popularityScale })
    }
    
    func sortRecommended(category:String) -> [Place]{
        return getListOfPlacesChosenByCategory(category).sorted(by: {$0.starRating > $1.starRating })
    }
    
    private func getListOfPlacesChosenByCategory(_ category:String)->[Place]{
        var chosenPlaces = [Place]()
        for place in places {
            if (place.categoryBelonging.contains(category)) {
                chosenPlaces.append(place)
            }
        }
        return chosenPlaces
    }
    static let shared = REST_Request()
    
}
