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
        app.buttons["Login"].tap()
        
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
        app.buttons["Login"].tap()
        
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
    
    
    func testDashboardProfileTap(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()

        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        
        //Action : Clicks on profile after checking if it exists
        XCTAssert(elementsQuery.buttons["profile"].exists)
        elementsQuery.buttons["profile"].tap()
        
        //Expected Result: Profile is being viewed
        XCTAssert(elementsQuery.staticTexts["About me"].exists)
        elementsQuery.buttons["left arrow"].tap()
    }
    
    func testDashboardMostPopularTap(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let popularPlace = app.scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.cells.staticTexts["Arcades and Laneways"]/*[[".cells.staticTexts[\"Arcades and Laneways\"]",".staticTexts[\"Arcades and Laneways\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssert(popularPlace.exists)
        //Action : Taps on a popular place in the collection view
        popularPlace.tap()
        
        let validTitle = "Arcades and Laneways"
        let arcadesAndLanewaysStaticText = app.staticTexts["Arcades and Laneways"]
        //Expected Result: Popular place which is being clicked appears in a bigger view
        XCTAssertEqual(validTitle, arcadesAndLanewaysStaticText.firstMatch.label)
    }
    
    func testDashboardSeeAll(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let mostPopularElementsQuery = app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular")
        let popularSeeAll = mostPopularElementsQuery.children(matching: .button).matching(identifier: "See all").element(boundBy: 0)
        XCTAssert(popularSeeAll.exists)
        //Action : Clicks on see all button
        popularSeeAll.tap()
        
        //Expected Result: See all Appears
        //go back home
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
        
        let recommendedSeeAll = mostPopularElementsQuery.children(matching: .button).matching(identifier: "See all").element(boundBy: 1)
        //Expected Result: See all appears
        XCTAssert(recommendedSeeAll.exists)
        recommendedSeeAll.tap()
    }
    
    func testTaBBar(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        
        //Action : Clicks on to go to the dashboard
        app.buttons["Login"].tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let tabBar = window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        XCTAssert(tabBar.exists)
        
        let homeItem = tabBar.children(matching: .other).element(boundBy: 0).children(matching: .button).element
        let favouriteItem = tabBar.children(matching: .other).element(boundBy: 1).children(matching: .button).element
        let cameraItem = tabBar.children(matching: .other).element(boundBy: 2).children(matching: .button).element
        let feelingLuckyItem = tabBar.children(matching: .other).element(boundBy: 3).children(matching: .button).element
        
        //Expected Result: The navbar items appear correctly
        XCTAssert(homeItem.exists)
        XCTAssert(favouriteItem.exists)
        XCTAssert(cameraItem.exists)
        XCTAssert(feelingLuckyItem.exists)
        
        //------------------------//
        //Action & Result : After a nav bar item is pressed it should go to the correct storyboard
        
        favouriteItem.tap()
        favouriteItem.tap()
        XCTAssert(app.staticTexts["Favourites"].exists)
        
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
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //Action : Clicks on a place
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.staticTexts["Federation Square"].tap()
       
        let presentTitle = app.staticTexts["Federation Square"]
        let presentOpenTime = app.staticTexts["Open 24 Hours"]
        let presentRating =  app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let weather = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let likeBtn = app.buttons["heart"]
        let visitBtn = app.buttons["Visit"]
        
        //Expected Result: All the components should be visible
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
        
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //Action : Clicks on a place - Royal Botanical Garden
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 1).cells.otherElements.containing(.image, identifier:"place_botanical_garden").element.tap()
    
        let presentTitle = app.staticTexts["Royal Botanical Garden"]
        let presentOpenTime = app.staticTexts["7.30AM - 6.30PM"]
        
        //Expected Result: The actual details should match with the expected details
        XCTAssertEqual(validTitle, presentTitle.firstMatch.label)
        XCTAssertEqual(validOpenTime, presentOpenTime.firstMatch.label)
    }
    
    func testPlaceCorrectImage(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        //Action : Clicks on a place
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 1).cells.otherElements.containing(.image, identifier:"place_botanical_garden").element.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).images["place_botanical_garden"]
        //Expected Result: The image should exist in the background
        XCTAssert(element.exists)
    }
    
    
    func testPlaceGetDirections(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //Action : Clicks on a place and clicks on the visit button to get directions
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        app.staticTexts["Federation Square"].tap()
        
        let visitBtn = app.buttons["Visit"]
        
        //Expected Result: Visit button works for the prupose which is being defined and it is visible
        XCTAssert(visitBtn.exists)
        visitBtn.tap()
    }
    
    func testPlaceRatingValid(){
        let validRating = "Rating 4.8"
        
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        //Action : Clicks on a place
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 1).cells.otherElements.containing(.image, identifier:"place_botanical_garden").element.tap()
        
        let presentRating =  app.otherElements["Rating 4.8"]
        
        //Expected Result: Rating is verifiable with the expected result
        XCTAssertEqual(validRating, presentRating.firstMatch.label)
    }
    
    //------ FAVORUITES STORYBOARD ------//
    func testFavouritesExist(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        app.scrollViews.otherElements.containing(.staticText, identifier:"Most Popular").element.swipeUp()
        
        //Action : Clicks on to the favourites view
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
        let defaultText = app.staticTexts["No Favourites"]
        let title = app.staticTexts["Favourites"]
        
        //Expected Result: Main components exist which includes the title and the label which shows no favourites are there
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
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let selectionOne:String = "Federation Square"
        let selectionTwo:String = "Royal Botanical Garden"
        //Action : Navigates to favourites
        goToFavourites()
       
        let favouriteOne = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Federation Square"]/*[[".cells.staticTexts[\"Federation Square\"]",".staticTexts[\"Federation Square\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let favouriteTwo = app.collectionViews.staticTexts["Royal Botanical Garden"]

        //Expected Result: The labels match with the real data
        XCTAssertEqual(selectionOne, favouriteOne.firstMatch.label)
        XCTAssertEqual(selectionTwo,favouriteTwo.firstMatch.label)
    }
    
    func testFavouritesRemovingPlaces(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()

        goToFavourites()
        
        //Action : Disliking Places
        let window = app.children(matching: .window).element(boundBy: 0)
        let button = window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element
        button.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["0"]/*[[".cells.buttons[\"0\"]",".buttons[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["1"]/*[[".cells",".buttons[\"like\"]",".buttons[\"1\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let element = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
        button.tap()
         //Expected Result: The view gets empty
        XCTAssert(app.staticTexts["No Favourites"].exists)
    }
    
    func testFavouritesComponentCheck(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //Action : Navigates to faovurites
        goToFavourites()
        
        let expectedTitle:String = "Federation Square"
        let expectedRating:String = "Rating 5.0"
        let expectedCity:String = "Melbourne"
        let expectedOpenTime:String = "Open 24 Hours"
        
        let collectionViewsQuery = app.collectionViews
        
        //Expected Result: The main components in Favourites inside a place view should exist
        XCTAssert(collectionViewsQuery.staticTexts[expectedTitle].exists)
        XCTAssert(collectionViewsQuery.otherElements[expectedRating].exists)
        XCTAssert(collectionViewsQuery.staticTexts[expectedCity].exists)
        XCTAssert(collectionViewsQuery.staticTexts[expectedOpenTime].exists)
    }
    
    //------ FEELING LUCKY STORYBOARD ------//
    func testFeelingLuckyComponentCheck(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //Action : Navigates to feeling lucky view
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .button).element.tap()
        
        let mockImage = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).images["travel"]
        let title = app.staticTexts["I'm Feeling lucky"]
        //the string wants to be in the exact format to be testeed , perhaps the weird formatting
        let heroText = app.staticTexts["take me  to"]
        let globeButton = app.buttons["globe"]

        //Expected Result: All the components mentioned being visible
        XCTAssert(mockImage.exists)
        XCTAssert(title.exists)
        XCTAssert(heroText.exists)
        XCTAssert(globeButton.exists)
    }
    
    func testFeelingLuckyRandomPlace(){
        //Pre Condition : Successfully logged in
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        //Action : Navigates to feeling lucky view and clicks on the globe to trigger the action
        let window = app.children(matching: .window).element(boundBy: 0)
        window.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .button).element.tap()
        
        let globeButton = app.buttons["globe"]
        globeButton.tap()
        
        //waits until the animation is completed
        let exists = NSPredicate(format: "exists == 1")
        let visitBtn = app.buttons["Visit"]
        expectation(for: exists, evaluatedWith: visitBtn, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        //Expected Result: Place view of a randomly selected place will appear
        XCTAssert(visitBtn.exists)
    }
    
    //------ OVERALL USECASE STORYBOARD ------//
    func testOverall(){
        //Pre Condition : Successfully logged in
        //Actions : Navigate through the views without any errors
        //Results : Successful navigation
        loginSuccessSetUp()
        app.buttons["Login"].tap()
        
        let scrollViewsQuery = app.scrollViews
        
        let elementsQuery = scrollViewsQuery.otherElements
        let popularPlace = app.scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.cells.staticTexts["Arcades and Laneways"]/*[[".cells.staticTexts[\"Arcades and Laneways\"]",".staticTexts[\"Arcades and Laneways\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssert(popularPlace.firstMatch.exists)
        //Action : Taps on a popular place in the collection view
        popularPlace.tap()
        XCTAssert(app.staticTexts["Arcades and Laneways"].exists)
        //go back to the dashboard
        let leftArrowButton = app.buttons["left arrow"]
        leftArrowButton.tap()
        //Navigates back to the dashboard
        XCTAssert(app.staticTexts["Where"].exists)
        
        //Navigates to my profile
        let profile = elementsQuery.buttons["profile"]
        XCTAssert(profile.exists)
        profile.tap()
        //Checks if the view is complete
        let aboutMeElement = elementsQuery.staticTexts["About me"]
        XCTAssert(aboutMeElement.exists)
        //navigates back to the dashboard
        leftArrowButton.tap()
        
        //Selects two favourites
        let selectFavouriteOne = scrollViewsQuery.otherElements.containing(.staticText, identifier:"Most Popular").children(matching: .collectionView).element(boundBy: 2).children(matching: .cell).element(boundBy: 0).buttons["heart"]
        selectFavouriteOne.tap()
        let selectFavouriteTwo = scrollViewsQuery.otherElements.collectionViews.buttons["heart"]
        selectFavouriteTwo.tap()
        
        //Navigates to Favourites
        let goToFavourites = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element
        goToFavourites.tap()
        //Checks if the correct places are being added to the favourites
        let favouriteElement = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Federation Square"]/*[[".cells.staticTexts[\"Federation Square\"]",".staticTexts[\"Federation Square\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(favouriteElement.exists)
        favouriteElement.tap()
        //Navigates inside a Place
        XCTAssert(app.buttons["Visit"].exists)
        //go back to the dashboard
        app.buttons["left arrow"].tap()
        
        //navigates to feeling lucky view
        let feelingLucky = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 3).children(matching: .button).element
        feelingLucky.tap()
        
        let globeBtn = app.buttons["globe"]
        globeBtn.tap()
        
        //waits until the animation is completed
        let exists = NSPredicate(format: "exists == 1")
        let visitBtn = app.buttons["Visit"]
        expectation(for: exists, evaluatedWith: visitBtn, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        
        //Place view of a randomly selected place will appear
        XCTAssert(visitBtn.exists)
        //go back to the dashboard
        leftArrowButton.tap()
        
        //Final Result
        XCTAssert(app.staticTexts["Where"].exists)
    }
}

