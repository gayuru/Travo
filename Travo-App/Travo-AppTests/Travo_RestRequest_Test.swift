//
//  Travo_RestRequest_Test.swift
//  Travo-AppTests
//
//  Created by Gayuru Gunawardana on 19/10/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyJSON

class Travo_RestRequest_Test: XCTestCase, Refresh  {
    func updateUI() {
        // Leave empty
    }
    var request:RestRequest = RestRequest.init(lat: "", lng: "")
    
    let categoryExample:String = "bar"
    let lat:String = "-37.813629"
    let lng:String = "144.963058"
    let examplePlace:Place = Place.init(name: "testPlace", desc: "testDesc", location: "testLocation", address: "testAddr", imageURL: "testImg", openTime: "testTime", starRating: 3, weatherCondition: 250, categoryBelonging: ["bar"])
    let examplePlaceAlt:Place = Place.init(name: "testPlaceAlt", desc: "testDescAlt", location: "testLocationAlt", address: "testAddrAlt", imageURL: "testImgAlt", openTime: "testTimeAlt", starRating: 4, weatherCondition: 250, categoryBelonging: ["bar"])
    

    
    override func setUp() {
        super.setUp()
        request.delegate = self
        request.updateLocation(lat: lat, lng: lng)
    }

    override func tearDown() {
        super.tearDown()
        request = RestRequest.init(lat: "", lng: "")
    }
    
    func testSortPlaces() {
        /* Pre Condition : Request Places Array has 2 values
         * Array[0] has a lower rating than Array[1]
         * Both Place objects belong to the same category that is being sorted
        */
        request.updatePlaceArr(place: examplePlace, weather: examplePlace.weatherCondition)
        request.updatePlaceArr(place: examplePlaceAlt, weather: examplePlaceAlt.weatherCondition)
        
        // Action : sorts the Array from Highest to Lowest Ratings
        let sortedPlaces:[Place] = request.sortPopularity(category: categoryExample)

        // Expected Result: Place with Higher Rating has a lower Index that the other
        XCTAssert(sortedPlaces[0].name != examplePlace.name &&
                    sortedPlaces[0].starRating >= sortedPlaces[1].starRating &&
                    sortedPlaces[0].starRating == examplePlaceAlt.starRating &&
                    sortedPlaces[1].starRating == examplePlace.starRating)
    }
    
    func testInsertPlace() {
        /* Pre Condition : Request Place Array has 0 values
         * RestRequest is initialized in the the header
        */

        // Action : inserts a valid Place into the Place Array
        request.updatePlaceArr(place: examplePlace, weather: examplePlace.weatherCondition)
        
        // Expected Result: Place Array contains 1 Place object and it is the object inserted
        XCTAssert(request.places.count == 1 &&
        request.places[0].name == examplePlace.name)
    }
    
    func testParsePlaceJSON() {
        /* Pre Condition : Request Place Array has 0 values
         * RestRequest is initialized in the the header
         * Valid JSON containing basic key value pairs for a place
         */
        let jsonDictionary:[String:Any] = ["name":"location", "rating":2]
        
        // Action : convert [String:Any] into a JSON Object
        let json = JSON(jsonDictionary)
        // Action : decomposes JSON into Place Object
        let placeObject = request.getPlaceObject(p: json)
        
        // Expected Result: Place Object Created with Given Values
        XCTAssert(placeObject.name == "location" &&
                    placeObject.starRating == 2)
    }
    
    func testFailedParsePlaceJSON() {
        /* Pre Condition : Request Place Array has 0 values
         * RestRequest is initialized in the the header
         * Invalid JSON containing junk key value pairs for a place
         */
        let jsonDictionary:[String:Any] = ["junk":10000]
        
        // Action : convert [String:Any] into a JSON Object
        let json = JSON(jsonDictionary)
        // Action : decomposes JSON into Place Object
        let placeObject = request.getPlaceObject(p: json)
        
        // Expected Result: Place Object Created with Default Values for safety
        XCTAssert(placeObject.name == "Place name" &&
                    placeObject.desc == "No available description" &&
                    placeObject.starRating == 0.0)
    }
}
