//
//  VoteDecision.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-26.
//

import Foundation
import UIKit


/// The outcome of a vote by the council
enum VoteDecision: String {
    case carriedUnanimously = "Carried Unanimously"
    case carried = "Carried"
    case lost = "Lost"
    
    func getRelatedColour() -> UIColor {
        switch self {
        case .carriedUnanimously:
            return .systemMint
        case .carried:
            return .systemGreen
        case .lost:
            return .systemRed
        }
    }
}
