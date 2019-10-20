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
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
    }
    
    func testARegisterSetup(){
        //Pre Condition: Unit Tests only work if CoreData does not have an existing user
    if(XCUIApplication().staticTexts["Create Account"].exists){
            let app = XCUIApplication()
            let nameTextField = app.textFields["Name"]
            nameTextField.tap()
            nameTextField.typeText("John")
            
            let emailTextField = app.textFields["Email"]
            emailTextField.tap()
            emailTextField.typeText("email1")
            
            let passwordTextField = app.secureTextFields["Password"]
            passwordTextField.tap()
            passwordTextField.typeText("password1")
            
            app.buttons["Sign up"].tap()
            let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
            let allowBtn = springboard.buttons["Allow"]
            if allowBtn.exists {
                allowBtn.tap()
            }
        }else{
            loginSuccessSetUp()
            let app = XCUIApplication()
            let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
            let allowBtn = springboard.buttons["Allow"]
            if allowBtn.exists {
                allowBtn.tap()
            }
        }
    }
    
    //Common setup for a successful login - PRE CONDITION FOR MOST OF THE TEST CASES
    func loginSuccessSetUp(){
        let logoElementsQuery = XCUIApplication().otherElements.containing(.image, identifier:"Logo")
        let textField = logoElementsQuery.children(matching: .textField).element
        textField.tap()
        textField.typeText("email1")
        textField.typeText("\n")
        let secureTextField = logoElementsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password1")
        secureTextField.typeText("\n")
        
        app.buttons["Login"].tap()
        
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let allowBtn = springboard.buttons["Allow"]
        if allowBtn.exists {
            allowBtn.tap()
        }

    }
    
    
    //------ LOGIN STORYBOARD ------//
    func testValidLoginSuccess(){
        //Pre Condition: The app should be installed and the user should be brought into the login screen
        let logoElementsQuery = XCUIApplication().otherElements.containing(.image, identifier:"Logo")
        let textField = logoElementsQuery.children(matching: .textField).element
        
        //Action : Valid Login Credentials are being typed
        textField.tap()
        textField.typeText("email1")
        textField.typeText("\n")
        
        let secureTextField = logoElementsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password1")
        secureTextField.typeText("\n")
        app.buttons["Login"].tap()
        
        //Expected Result : Login Successful
        XCTAssertFalse(app.alerts.element.exists)
    }
    
    func testInvalidLogin_missingCredentials(){
        //Pre Condition: The app should be installed and the user should be brought into the login screen
        let logoElementsQuery = XCUIApplication().otherElements.containing(.image, identifier:"Logo")
        let textField = logoElementsQuery.children(matching: .textField).element
        
        //Action : Login Credentials are not being completed fully
        textField.tap()
        textField.typeText("email_Fail")
        textField.typeText("\n")

        let secureTextField = logoElementsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password_Fail")
        secureTextField.typeText("\n")
        app.buttons["Login"].tap()
        
        //Expected Result : Alert indicating that the login was unsuccessful
        XCTAssertEqual(app.alerts.element.label, "Incorrect Login")
    }
    
    func testInvalidLogin_wrongCredentials(){
        //Pre Condition : The app should be installed and the user should be brought into the login screen
        let logoElementsQuery = XCUIApplication().otherElements.containing(.image, identifier:"Logo")
        
        //Action : Wrong Login Credentials are being typed
        let textField = logoElementsQuery.children(matching: .textField).element
        textField.tap()
        textField.typeText("email1")
        textField.typeText("\n")
        
        let secureTextField = logoElementsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password_Fail")
        secureTextField.typeText("\n")
        app.buttons["Login"].tap()
        
        //Expected Result : Alert indicating that the login was unsuccessful
        XCTAssertEqual(app.alerts.element.label, "Incorrect Login")
    }
     
    
    //------ DASHBOARD STORYBOARD ------//
    func testDashboardLoads(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        
        //Action : Views the dashboard
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let willYouGoTodayStaticText = elementsQuery.staticTexts["will you go\ntoday?"]
     
        //Expected Result: The dashboard loads with the initial components
        XCTAssert(elementsQuery.buttons["Logo"].exists)
        XCTAssert(elementsQuery.staticTexts["Where"].exists)
        XCTAssert(willYouGoTodayStaticText.exists)
}
    
    func testDashboardMainComponentsVisible(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        
        //Action : Logs into the dashboard
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let collectionView = scrollViewsQuery.otherElements.collectionViews.element
        let mostPopularElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Most Popular")
        
        //Expected Result: All the main components are visible including the title,collection vies and buttons
        XCTAssert(elementsQuery.staticTexts["Most Popular"].exists)
        XCTAssert(elementsQuery.staticTexts["Recommended"].exists)
        XCTAssert(collectionView.exists)
        XCTAssert (mostPopularElementsQuery.children(matching: .button).matching(identifier: "See all").element(boundBy: 0).exists)
        XCTAssert(mostPopularElementsQuery.children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
}

