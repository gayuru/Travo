//
//  Places.swift
//  Travo-App
//
//  Created by Sogyal Thundup Sherpa on 10/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class Place:NSObject{
    var name:String
    var desc:String
    var location:String
    var address:String
    var imageURL:String
    var openTime:String
    var starRating:Double
    var weatherCondition:Int
    var categoryBelonging:[String]
    init(name:String,desc:String,location:String,address:String,imageURL:String,openTime:String,starRating:Double,weatherCondition:Int,categoryBelonging:[String]){
        self.name = name
        self.desc = desc
        self.location = location
        self.address = address
        self.imageURL = imageURL
        self.openTime = openTime
        self.starRating = starRating
        self.weatherCondition = weatherCondition
        self.categoryBelonging = categoryBelonging
    }
}
