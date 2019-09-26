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
    
    
    var places:[Place]{
        return _places
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
    }
    
    func getPlaceData(_ endpoint:String, parameters:Parameters){
        AF.request(endpoint, method: .get, parameters: parameters).validate().responseJSON{
            (response) in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
                let items = json["response"]["groups"][0]["items"]
                if (items.count > 0){
                    for result in items{
                        if let name = result.1["venue"]["name"].string{
                            print(name)
                        }
                    }
                }else{
                    
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
        
    }
    
    //    func getPlaces(lat:String,lng:String,category:String){
    //        _places = []
    //        //EXAMPLE URL -> https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY
    //        let urlString = base_url + paramLocation + lat + latlngSeparator + lng + paramSeparator + defaultRadius + paramSeparator + paramType + category + paramSeparator + paramAPIKEY + googleAPIKey
    //
    //        if let url = URL(string: urlString){
    //            getData(url)
    //        }
    //    }
    //
    //
    //    private func getData(_ url: URL)
    //    {
    //        AF.request(url)
    //            .validate()
    //            .responseJSON{ (response) in
    //                switch response.result{
    //                case.success(let value):
    //                    let json = JSON(value)
    //                    print(json)
    //                    let allResults = json["results"].arrayValue
    //                    if (allResults.count > 0){
    //                        for result in allResults{
    //                            let name = result["name"].string
    //                            let starRating  = result["rating"].double
    //                            print(name!)
    //                        }
    //                    }else{
    //                        print("No Results")
    //                    }
    //
    //                case .failure(let error):
    //                    print("\(error.localizedDescription)")
    //                }
    //            }
    //        }
    
}








