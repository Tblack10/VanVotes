//
//  Vote.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-26.
//

import Foundation


/// An individual vote from a councillor
enum Vote: String {
    case favour = "In Favour"
    case opposition = "In Opposition"
    case absent = "Absent"
    case abstain = "Abstain"
    case conflict = "Declared Conflict"
}
