//
//  ComicDetailsSuccessUITests.swift
//  DisneyTakeHomeProjectUITests
//
//  Created by Chang Woo Choi on 9/22/22.
//

import XCTest

class ComicDetailsSuccessUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app =  XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success": "1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }

    func test_comicDetails_views_success() {
        let scrollView = app.scrollViews
        XCTAssertTrue(scrollView.element.waitForExistence(timeout: 5), "ScrollView is visible")
        
        let containerView = app.otherElements["comicDetailsStackView"]
        XCTAssertTrue(containerView.waitForExistence(timeout: 5), "containerView is visible")
        
        let imageView = app.images
        XCTAssertTrue(imageView.element.waitForExistence(timeout: 5), "imageView is visible")
        
        let labels = app.staticTexts
        XCTAssertTrue(labels.element.waitForExistence(timeout: 5), "label is visible")
        
        XCTAssertEqual(labels.count, 2, "Label count is 2")

        
        XCTAssertTrue(labels["Jubilee (2004) #3"].exists)
        
        let longText = "Payton-Noble High's newest and spunkiest recruit, Jubilee, finds herself caught between her classmates and an L.A. gang rivalry. Can everyone's favorite mutant mallrat handle it in the barrio, or will Jubilee fall prey to South Central's own special blend of hospitality? And what the heck is Aunt Hope doing with all those firearms?"
        
         let predicate = NSPredicate(format: "label CONTAINS[c] %@", longText)
         let element = labels.element(matching: predicate)

        XCTAssertTrue(element.exists)


    }
   
}
