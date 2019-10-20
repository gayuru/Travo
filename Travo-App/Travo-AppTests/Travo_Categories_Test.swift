//
//  Travo_Categories_Test.swift
//  Travo-AppTests
//
//  Created by Gayuru Gunawardana on 20/10/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import XCTest

class Travo_Categories_Test: XCTestCase {

    var categories:Categories? = Categories.init()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        categories = Categories.init()
    }
    
    func testGenerateCategories() {
        // Pre Condition : Catgories class is being initialised in the header
        /* After initialising the categories should be generated*/
        
        //should have 10 categories
        let categoryCount:Int = 10
        
        //Action : generate the categories desired
        let resultCount:Int? = categories?.getCategoryList().count

        //Expected Result: Categories are generated
        XCTAssert(categoryCount == resultCount, "The respected categories are being generated")
    }
    
    func testCategoryExists(){
        // Pre Condition : Catgories class is being initialised in the header
        /* After initialising the categories should be generated therefore all the categories should be listed */
        
        //the list of the categories
        let categoryNameList = ["general","art", "bar", "beach", "cafe", "coffee", "hike", "library", "monument", "park"]
        
        var exists:Bool? = false
        //Action: check if all the categories exist
        for category in categoryNameList{
            exists = (categories?.getCategoryList().contains(where: { (Category) -> Bool in
                category == Category.getName()
            }))!
            if(exists == false){
                return
            }
        }
        
        //Expected Result: All the categories are being generated successfully
        XCTAssert(exists!, "Checks if all the categories are inside the list")
    }
    
    func testEnabledCategoryImage(){
        // Pre Condition : Catgories class is being initialised in the header
        /* After initialising the category images should generated with relevant naming standards */
        
        //the name which is being passed as a category
        let cName:String = "general"
        //the expected result
        let expectedCname:String = "category_general_enabled"
        
        //Action: The name is being generated via the function for it to follow the naming standards
        let resultCName:String = (categories?.getEnabledImageFromCategory(name: cName))!
        
        //Expected Result: The image name has been defined according to the naming standards
        XCTAssert(expectedCname == resultCName, "The enabled image naming is standard")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
