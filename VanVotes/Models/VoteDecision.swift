//
//  VoteDecision.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-26.
//

import Foundation


/// The outcome of a vote by the council
enum VoteDecision: String {
    case carriedUnanimously = "Carried Unanimously"
    case carried = "Carried"
    case lost = "Lost"
    
}
