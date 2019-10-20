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
        super.setUp()
        w1 = weather.updateWeatherIcon(condition: 250)
    }

    override func tearDown() {
        super.tearDown()
        weather.condition = 0
    }

    func testCondition() {
        let w:String = weather.updateWeatherIcon(condition: 400)
        XCTAssert(w != w1)
    }
    
    func testStorm(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
    
        //range should 0..300 & 772.799
        let expectedCondStormOne:String = "tstorm1"
        let expectedCondStormTwo:String = "tstorm3"
        
        //Action : gets the condition for the specific weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 200)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 10)
        
        let resultCondThree:String = weather.updateWeatherIcon(condition: 774)
        let resultCondFour:String = weather.updateWeatherIcon(condition: 788)
        
        //Expected Result: Storms of type 1 should appear
        XCTAssert(
            expectedCondStormOne == resultCondOne &&
            expectedCondStormOne == resultCondTwo,
            "Test : Condition checking for Storms of type 1"
        )
        
        //Expected Result: Storms of type 3 should appear
        XCTAssert(
            expectedCondStormTwo == resultCondThree &&
            expectedCondStormTwo == resultCondFour,
            "Test : Condition checking for Storms of type 3"
        )
    }

    func testLightRain(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
        
        //range should be 301..500
        let expectedCondLR:String = "light_rain"
        
        //Action : gets the condition for the specific weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 302)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 499)
        
        //Expected Result: Light rains should appear
        XCTAssert(
            expectedCondLR == resultCondOne &&
            expectedCondLR == resultCondTwo,
            "Test : Condition checking for light rains"
        )
    }
    
    func testShower(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
        
        //range should 501.600
        let expectedCondS:String = "shower3"
        
        //Action : gets the condition for the specific weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 505)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 589)
        
        //Expected Result: Showers should appear
        XCTAssert(
            expectedCondS == resultCondOne &&
                expectedCondS == resultCondTwo,
            "Test : Condition checking for Showers"
        )
    }
    
    func testSunny(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
        
        //range should 800 & 904
        let expectedCondSny:String = "sunny"
        
        //Action : gets the condition for the specific weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 800)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 904)
        
        //Expected Result: Condition should appear as sunny
        XCTAssert(
            expectedCondSny == resultCondOne &&
                expectedCondSny == resultCondTwo,
            "Test : Condition checking for being Sunny"
        )
    }
    
    func testCloudy(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
        
        //range should 801..804
        let expectedCondC:String = "cloudy2"
        
        //Action : gets the condition for the specific weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 802)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 803)
        
        //Expected Result: Condition should appear as cloudy
        XCTAssert(
            expectedCondC == resultCondOne &&
                expectedCondC == resultCondTwo,
            "Test : Condition checking for being cloudy"
        )
    }
    
    
    func testFog(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
        
        //range should 701.771
        let expectedCondC:String = "fog"
        
        //Action : gets the condition for the specific weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 770)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 705)
        
        //Expected Result: Condition should appear as fog
        XCTAssert(
            expectedCondC == resultCondOne &&
                expectedCondC == resultCondTwo,
            "Test : Condition checking for having fog"
        )
    }
    
    func testSnow(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
        
        //range should 601...700 & 903
        let expectedCondSnowFour:String = "snow4"

        //Action : gets the condition for the specific weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 605)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 660)
        
        //Expected Result: Condition should appear as snow of type 4
        XCTAssert(
            expectedCondSnowFour == resultCondOne &&
            expectedCondSnowFour == resultCondTwo,
            "Test : Condition checking for snows of type 4"
        )
    }
    
    func testInvalid(){
        // Pre Condition : Weather is defined
        /* Weather is defined in the class header for tests */
        
        //range anything more than 1000
        let expectedCondC:String = "dunno"
        
        //Action : gets the condition for an invalid weather condition
        let resultCondOne:String = weather.updateWeatherIcon(condition: 5000)
        let resultCondTwo:String = weather.updateWeatherIcon(condition: 99999)
        
        //Expected Result: Condition should appear invalid
        XCTAssert(
            expectedCondC == resultCondOne &&
                expectedCondC == resultCondTwo,
            "Test : Condition checking for being invalid"
        )
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
