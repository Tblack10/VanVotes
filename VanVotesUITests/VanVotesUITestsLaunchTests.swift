//
//  VanVotesUITestsLaunchTests.swift
//  VanVotesUITests
//
//  Created by Travis Black on 2022-05-24.
//

import XCTest

class VanVotesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways

        add(attachment)
    }
    
    func testCouncillor_WhenTapped_ShouldReturnResults() {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Councillor Sarah Kirby-Yung"]/*[[".cells.staticTexts[\"Councillor Sarah Kirby-Yung\"]",".staticTexts[\"Councillor Sarah Kirby-Yung\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count > 0)
    }
}
