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
    
    //MARK: LandingVC Tests
    func testThatAllCouncillorsAreVisibleOnLandingVC() {
        
    }
    
    //MARK: VotesVC Tests
    
    //MARK: CouncillorVotesVC Tests
    
    //MARK: VoteDetailVC Tests
}
