//
//  VanVotesUITests.swift
//  VanVotesUITests
//
//  Created by Travis Black on 2022-05-24.
//

import XCTest

class VanVotesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false

        let device = XCUIDevice.shared
        device.orientation = .portrait
    
        app = XCUIApplication()
        app.launch()
    }
        
    func testCouncillor_WhenTapped_ShouldReturnResults() {
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count == 11)
    }
    
    func testPreviousCouncillor_WhenTapped_ShouldReturnResults() {
        let buttonsQuery = XCUIApplication().buttons
        buttonsQuery.staticTexts["View Previous Councillors"].tap()
        
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count > 0)
    }
    

    func testAllVotes_WhenTapped_ShouldReturnResults() {
        let buttonsQuery = XCUIApplication().buttons
        buttonsQuery.staticTexts["View All Votes"].tap()
        let cells = app.tables.element(boundBy: 0).cells.element.waitForExistence(timeout: 5)
      
        XCTAssertTrue(cells.description.count > 0)
        
    }
}
