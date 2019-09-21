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
    
    //Common setup for a successful login
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
    }
    
    //------ OVERALL USECASE STORYBOARD ------//
    func testOverall(){
        
    }
    
    //Tests _ Login storyboard
    //pre-condition, action and post condition should be present with comments
    func testValidLoginSuccess(){
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
        XCTAssertFalse(app.alerts.element.exists)
    }
    
    func testInvalidLogin_missingCredentials(){
        let logoElementsQuery = XCUIApplication().otherElements.containing(.image, identifier:"Logo")
        let textField = logoElementsQuery.children(matching: .textField).element
        textField.tap()
        textField.typeText("email_Fail")
        textField.typeText("\n")

        let secureTextField = logoElementsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password_Fail")
        secureTextField.typeText("\n")
        app.buttons["Login"].tap()
        XCTAssertEqual(app.alerts.element.label, "Incorrect Login")
    }
    
    func testInvalidLogin_wrongCredentials(){
        let logoElementsQuery = XCUIApplication().otherElements.containing(.image, identifier:"Logo")
        let textField = logoElementsQuery.children(matching: .textField).element
        textField.tap()
        textField.typeText("email1")
        textField.typeText("\n")
        
        let secureTextField = logoElementsQuery.children(matching: .secureTextField).element
        secureTextField.tap()
        secureTextField.typeText("password_Fail")
        secureTextField.typeText("\n")
        app.buttons["Login"].tap()
        XCTAssertEqual(app.alerts.element.label, "Incorrect Login")
    }
     
    
    //------ DASHBOARD STORYBOARD ------//
    //pre-condition
    func testDashboardLoads(){
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        let willYouGoTodayStaticText = elementsQuery.staticTexts["will you go\ntoday?"]
     
        XCTAssert(elementsQuery.buttons["Logo"].exists)
        XCTAssert(elementsQuery.staticTexts["Where"].exists)
        XCTAssert(willYouGoTodayStaticText.exists)
}
    
    func testDashboardMainComponentsVisible(){
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let collectionView = scrollViewsQuery.otherElements.collectionViews.element
        let mostPopularElementsQuery = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Most Popular")
        
        XCTAssert(elementsQuery.staticTexts["Most Popular"].exists)
        XCTAssert(elementsQuery.staticTexts["Recommended"].exists)
        XCTAssert(collectionView.exists)
        XCTAssert (mostPopularElementsQuery.children(matching: .button).matching(identifier: "See all").element(boundBy: 0).exists)
        XCTAssert(mostPopularElementsQuery.children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
    
    func testDashboardProfileTap(){
        loginSuccessSetUp()
        app.buttons["Login"].tap()

        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        XCTAssert(elementsQuery.buttons["profile"].exists)
        elementsQuery.buttons["profile"].tap()
        XCTAssert(elementsQuery.staticTexts["About me"].exists)
        elementsQuery.buttons["left arrow"].tap()
    }
    
    //To-Do
    func testDashboardCategoryChange(){
    }
    
    func testDashboardMostPopularTap(){
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let popularPlace = app.scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.cells.staticTexts["Arcades and Laneways"]/*[[".cells.staticTexts[\"Arcades and Laneways\"]",".staticTexts[\"Arcades and Laneways\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssert(popularPlace.exists)
        popularPlace.tap()
        
        let validTitle = "Arcades and Laneways"
        let arcadesAndLanewaysStaticText = app.staticTexts["Arcades and Laneways"]
        XCTAssertEqual(validTitle, arcadesAndLanewaysStaticText.firstMatch.label)
    }
    
    func testDashboardSeeAll(){
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let mostPopularElementsQuery = app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular")
        let popularSeeAll = mostPopularElementsQuery.children(matching: .button).matching(identifier: "See all").element(boundBy: 0)
        XCTAssert(popularSeeAll.exists)
        popularSeeAll.tap()
        
        //go back home
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
        
        let recommendedSeeAll = mostPopularElementsQuery.children(matching: .button).matching(identifier: "See all").element(boundBy: 1)
        XCTAssert(recommendedSeeAll.exists)
        recommendedSeeAll.tap()
    }
    
    func testTaBBar(){
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let tabBar = window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        XCTAssert(tabBar.exists)
        
        let homeItem = tabBar.children(matching: .other).element(boundBy: 0).children(matching: .button).element
        let favouriteItem = tabBar.children(matching: .other).element(boundBy: 1).children(matching: .button).element
        let cameraItem = tabBar.children(matching: .other).element(boundBy: 2).children(matching: .button).element
        let feelingLuckyItem = tabBar.children(matching: .other).element(boundBy: 3).children(matching: .button).element
        
        XCTAssert(homeItem.exists)
        XCTAssert(favouriteItem.exists)
        XCTAssert(cameraItem.exists)
        XCTAssert(feelingLuckyItem.exists)
        
        //checks if its tappable
        favouriteItem.tap()
        favouriteItem.tap()
        //change this to favourites later
        XCTAssert(app.staticTexts["No Favourites"].exists)
        
        cameraItem.tap()
        XCTAssert(app.staticTexts["PHOTO"].exists)
        app.buttons["arrow point to right"].tap()
        
        feelingLuckyItem.tap()
        XCTAssert(app.staticTexts["I'm Feeling lucky"].exists)
        
        homeItem.tap()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        XCTAssert(elementsQuery.buttons["Logo"].exists)
    }
    
    //------ PLACE STORYBOARD ------//
    //Tests _ Place storyboard
    func testPlaceLabelsExist(){
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //action
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.staticTexts["Federation Square"].tap()
        
        
        //testing
        let presentTitle = app.staticTexts["Federation Square"]
        let presentOpenTime = app.staticTexts["Open 24 Hours"]
        let presentRating =  app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let weather = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let likeBtn = app.buttons["like"]
        let visitBtn = app.buttons["Visit"]
        
        XCTAssert(presentTitle.exists)
        XCTAssert(presentOpenTime.exists)
        XCTAssert(presentRating.exists)
        XCTAssert(visitBtn.exists)
        XCTAssert(likeBtn.exists)
        XCTAssert(weather.exists)
    }
    
    func testPlaceWithCorrectDetails(){
        let validTitle = "Royal Botanical Garden"
        let validOpenTime = "7.30AM - 6.30PM"
        
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        //action
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 1).cells.otherElements.containing(.image, identifier:"place_botanical_garden").element.tap()
    
        let presentTitle = app.staticTexts["Royal Botanical Garden"]
        let presentOpenTime = app.staticTexts["7.30AM - 6.30PM"]
        
        //testing
        XCTAssertEqual(validTitle, presentTitle.firstMatch.label)
        XCTAssertEqual(validOpenTime, presentOpenTime.label)
    }
    
    func testPlaceCorrectImage(){
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        //action
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 1).cells.otherElements.containing(.image, identifier:"place_botanical_garden").element.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).images["place_botanical_garden"]
        XCTAssert(element.exists)
    }
    
    
    func testPlaceGetDirections(){
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //action
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.staticTexts["Federation Square"].tap()
        
        let visitBtn = app.buttons["Visit"]
        XCTAssert(visitBtn.exists)
        visitBtn.tap()
    }
    
    func testPlaceRatingValid(){
        
        let validRating = "Rating 4.8"
        
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        //action
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 1).cells.otherElements.containing(.image, identifier:"place_botanical_garden").element.tap()
        
        let presentRating =  app.otherElements["Rating 4.8"]
        
        //testing
        XCTAssertEqual(validRating, presentRating.label)
    }
    
    //------ FAVORUITES STORYBOARD ------//
    func testFavouritesExist(){
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").element.swipeUp()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        let defaultText = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .collectionView).element
        let title = app.staticTexts["Favourites"]
        
        
        XCTAssert(defaultText.exists)
        XCTAssert(title.exists)
        XCTAssertEqual(defaultText.label, "No Favourites")
        XCTAssertEqual(title.label, "Favourites")
    }
    
    //helper method to add two favourites and go into the favourites view
    func goToFavourites(){
        let scrollViewsQuery = app.scrollViews
        
        let firstFavourite = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).buttons["heart"]
        firstFavourite.tap()
        let secondFavourite = scrollViewsQuery.otherElements.collectionViews/*@START_MENU_TOKEN@*/.buttons["heart"]/*[[".cells.buttons[\"heart\"]",".buttons[\"heart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        secondFavourite.tap()
        
        //move to favourites
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
    }
    
    func testFavouritesAddingPlaces(){
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let selectionOne:String = "Federation One"
        let selectionTwo:String = "Royal Botanical Garden"
        
        goToFavourites()
       
        let favouriteOne = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Federation Square"]/*[[".cells.staticTexts[\"Federation Square\"]",".staticTexts[\"Federation Square\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let favouriteTwo = app.collectionViews.staticTexts["Royal Botanical Garden"]

        XCTAssertEqual(selectionOne, favouriteOne.label)
        XCTAssertEqual(selectionTwo,favouriteTwo.label)
    }
    
    //should work after removing places is fixed
    func testFavouritesRemovingPlaces(){
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
       
        goToFavourites()
        
        let collectionViewsQuery = app.collectionViews
        //dislike
        let favouriteOne = collectionViewsQuery.children(matching: .cell).element(boundBy: 0).buttons["like"]
        favouriteOne.tap()
        let favouriteTwo = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).buttons["like"]
        favouriteTwo.tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let defaultText = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .collectionView).element
        XCTAssertEqual(defaultText.label, "No Favourites")
    }
    
    func testFavouritesComponentCheck(){
        //pre-condition
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        goToFavourites()
        
        let expectedTitle:String = "Federation Square"
        let expectedRating:String = "Rating 5.0"
        let expectedCity:String = "Melbourne"
        let expectedOpenTime:String = "Open 24 Hours"
        
        let collectionViewsQuery = app.collectionViews
        
        XCTAssert(collectionViewsQuery.staticTexts[expectedTitle].exists)
        XCTAssert(collectionViewsQuery.otherElements[expectedRating].exists)
        XCTAssert(collectionViewsQuery.staticTexts[expectedCity].exists)
        XCTAssert(collectionViewsQuery.staticTexts[expectedOpenTime].exists)
    }
    
    //------ FEELING LUCKY STORYBOARD ------//
    func testFeelingLuckyComponentCheck(){
        //pre-condition
        loginSuccessSetUp()
      
        //goto feeling lucky view
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .button).element.tap()
        
        let mockImage = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 0).images["travel"]
        let title = app.staticTexts["I'm Feeling lucky"]
        let heroText = app.staticTexts["take me to"]
        let globeButton = app.buttons["globe"]

        XCTAssert(mockImage.exists)
        XCTAssert(title.exists)
        XCTAssert(heroText.exists)
        XCTAssert(globeButton.exists)
    }
    
    
    
    
    
    
        
    }
    


    

