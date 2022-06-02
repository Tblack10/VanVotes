//
//  VanVotesTests.swift
//  VanVotesTests
//
//  Created by Travis Black on 2022-05-22.
//

import XCTest
@testable import VanVotes

class VVNetworkManagerTests: XCTestCase {

    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // Store Token
    // - Already Exists
    func testTokenAlreadyExistsHandledGracefully() {
    }
    // - Does Not Exist
    func testTokenDoesNotExistsHandledGracefully() {
    }
    
    // All votes from all councillors on an individual matter
    // - Successful Data
    func testCouncillorVotesOnMatterSuccessfullyRetrieved() {
        
    }
    // - Unsuccessful Data
    func testCouncillorVotesOnMatterUnsuccessfullyRetrieved() {
        
    }
    
    // All Votes that an individual councillor has cast
    // - Successful Data
    func testAllVotesForSingleCouncillorSuccessfullyRetrieved() {
        
    }
    // - Unsuccessful Data
    func testAllVotesForSingleCouncillorUnsuccessfullyRetrieved() {
        
    }
}
