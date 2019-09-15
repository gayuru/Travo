//
//  Travo_AppUITests.swift
//  Travo-AppUITests
//
//  Created by Gayuru Gunawardana on 15/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import XCTest

class Travo_AppUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Tests _ Login storyboard
    //pre-condition, action and post condition should be present with comments
    func testValidLoginSuccess(){
    }
    
    func testInvalidLogin_missingCredentials(){
    }
    
    func testInvalidLogin_wrongCredentials(){
    }
    
    
    //Tests _ Place storyboard
    func testPlace_lablesExist(){
        //pre-condition
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        
        //action
        app.scrollViews.otherElements.buttons["aiony haust 3TLl 97HNJo unspla"].tap()
        app.scrollViews.otherElements.buttons["aiony haust 3TLl 97HNJo unspla"].tap()
        
        //testing
        let presentTitle = app.staticTexts["National Gallery of Victoria"].exists
        let presentOpenTime = app.staticTexts["10AM - 5PM"].exists
        let presentRating = app.staticTexts["4.7"].exists
        
        XCTAssertTrue(presentTitle && presentOpenTime && presentRating)
    }
    
    func testPlace_withCorrectDetails(){
        
        let validTitle = "National Gallery of Victoria"
        let validOpenTime = "10AM - 5PM"
        let validRating = "4.7"
        
        //pre-condition
        let app = XCUIApplication()
        app.buttons["Login"].tap()
        
        //action
        app.scrollViews.otherElements.buttons["aiony haust 3TLl 97HNJo unspla"].tap()
        app.scrollViews.otherElements.buttons["aiony haust 3TLl 97HNJo unspla"].tap()
        
        let presentTitle = app.staticTexts["National Gallery of Victoria"]
        let presentOpenTime = app.staticTexts["10AM - 5PM"]
        let presentRating = app.staticTexts["4.7"]
        
        //testing
        XCTAssertEqual(validTitle, presentTitle.label)
        XCTAssertEqual(validOpenTime, presentOpenTime.label)
        XCTAssertEqual(validRating, presentRating.label)
    }
    
    func testPlace_CorrectImage(){
       
    }
    
    
    func testPlace_getDirections(){
        
    }
    
    func testPlace_ratingValid(){
        
    }
    
   

}
