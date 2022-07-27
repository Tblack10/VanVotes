//
//  File.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-17.
//

import Foundation

// MARK: - Response
struct Response: Codable, Hashable {
    let totalCount: Int
    let links: [Link]
    let records: [RecordElement]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case links, records
    }
}

// MARK: - Link
struct Link: Codable, Hashable {
    let rel: String
    let href: String
}

// MARK: - RecordElement
struct RecordElement: Codable, Hashable {
    let links: [Link]
    let record: RecordRecord
}

// MARK: - RecordRecord
struct RecordRecord: Codable, Hashable {
    let id, timestamp: String
    let size: Int
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable, Hashable {
    
    let meetingType: String
    let voteDate: String
    let voteNumber: String
    let agendaDescription: String
    let voteStartDateTime: String
    let councilMember: String
    let vote: String
    let decision: String
    let voteDetailID: String
    
    // Uniquely Identify the Vote
    let identifier = UUID()

    enum CodingKeys: String, CodingKey {
        case meetingType = "meeting_type"
        case voteDate = "vote_date"
        case voteNumber = "vote_number"
        case agendaDescription = "agenda_description"
        case voteStartDateTime = "vote_start_date_time"
        case councilMember = "council_member"
        case vote, decision
        case voteDetailID = "vote_detail_id"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
