//
//  Travo_Weather_Test.swift
//  Travo-AppTests
//
//  Created by Gayuru Gunawardana on 19/10/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import XCTest

class Travo_Weather_Test: XCTestCase {

    var weather:Weather = Weather()
    var w1:String?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        w1 = weather.updateWeatherIcon(condition: 250)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        weather.condition = 0
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let w:String = weather.updateWeatherIcon(condition: 400)
        XCTAssert(w != w1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
