//
//  Vote.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-26.
//

import Foundation
import UIKit


/// An individual vote from a councillor
enum Vote: String {
    case favour = "In Favour"
    case opposition = "In Opposition"
    case absent = "Absent"
    case abstain = "Abstain"
    case conflict = "Declared Conflict"
    
    func getRelatedImage() -> UIImage{
        let largeConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)

        switch self {
        case .favour:
            return UIImage(systemName: "person.crop.circle.fill.badge.checkmark", withConfiguration: largeConfiguration)!
        case .opposition: 
            return UIImage(systemName: "person.crop.circle.fill.badge.xmark", withConfiguration: largeConfiguration)!
        case .absent:
            return UIImage(systemName: "person.crop.circle.badge.questionmark.fill", withConfiguration: largeConfiguration)!
        case .abstain:
            return UIImage(systemName: "person.crop.circle.fill.badge.minus", withConfiguration: largeConfiguration)!
        case .conflict:
            return UIImage(systemName: "heart.text.square", withConfiguration: largeConfiguration)!
        }
    }
}
