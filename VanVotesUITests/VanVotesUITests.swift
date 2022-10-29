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
        let table = app.tables.element(boundBy: 0).cells.element(boundBy: 0)
        
        XCTAssertTrue(table.waitForExistence(timeout: 10), "Expected table to load but did not load")
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        XCTAssertTrue(table.waitForExistence(timeout: 10), "Expected table to load but did not load")
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        XCTAssertTrue(table.waitForExistence(timeout: 10), "Expected table to load but did not load")
        
        let cells = app.tables.element(boundBy: 0).cells.count
        XCTAssertTrue(cells == 11, "Expected 11 cells but \(cells) found")
    }
    
    func testPreviousCouncillor_WhenTapped_ShouldReturnResults() {
        let buttonsQuery = XCUIApplication().buttons
        buttonsQuery.staticTexts["View Previous Councillors"].tap()
        
        XCTAssertTrue(app.tables.element(boundBy: 0).cells.count > 0, "Expected previous councillors to be displayed but were not displayed")
    }
    

    func testAllVotes_WhenTapped_ShouldReturnResults() {
        let buttonsQuery = XCUIApplication().buttons
        buttonsQuery.staticTexts["View All Votes"].tap()
        let cells = app.tables.element(boundBy: 0).cells.element.waitForExistence(timeout: 5)
      
        XCTAssertTrue(cells.description.count > 0, "Expected all votes to be displayed but were not displayed")
        
    }
}
