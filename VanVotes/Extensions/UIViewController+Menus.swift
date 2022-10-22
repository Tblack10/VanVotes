//
//  UIViewController+ColourMenu.swift
//  VanVotes
//
//  Created by Travis Black on 2022-10-22.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Creates a menu in the nav bar with a description of the vote result  colours
    func createColourMenu() {
        let results = UIMenu(title: "Results", options: .displayInline, children: [
            UIAction(title: "Passed Unanimously",
                     image: UIImage(systemName: "square.fill")!.withTintColor(.systemMint, renderingMode: .alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Passed",
                     image: UIImage(systemName: "square.fill")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Did not pass",
                     image: UIImage(systemName: "square.fill")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
                     handler: { (_) in }),
        ])
        
        let votes = UIMenu(title: "Individual Votes", options: .displayInline, children: [
            UIAction(title: "Favour",
                     image: Vote.favour.getRelatedImage().withTintColor(Vote.favour.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Opposition",
                     image: Vote.opposition.getRelatedImage().withTintColor(Vote.opposition.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Absent",
                     image: Vote.absent.getRelatedImage().withTintColor(Vote.absent.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Conflict",
                     image: Vote.conflict.getRelatedImage().withTintColor(Vote.conflict.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Abstain",
                     image: Vote.abstain.getRelatedImage().withTintColor(Vote.abstain.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Ineligible",
                     image: Vote.ineligible.getRelatedImage().withTintColor(Vote.ineligible.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "No Vote",
                     image: Vote.noVote.getRelatedImage().withTintColor(Vote.noVote.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in })
        ])
        
        let myMenu = UIMenu(title: "Help", children: [results, votes])
        
        let add = UIBarButtonItem(title: "Help", image: UIImage(systemName: "questionmark.circle"), primaryAction: nil, menu: myMenu)

        navigationItem.rightBarButtonItems = [add]
    }
    
    /// Creates the help menu for the people icons
    func createVoteMenu() {
        let items = UIMenu(title: "Help", options: .displayInline, children: [
            UIAction(title: "Favour",
                     image: Vote.favour.getRelatedImage().withTintColor(Vote.favour.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Opposition",
                     image: Vote.opposition.getRelatedImage().withTintColor(Vote.opposition.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Absent",
                     image: Vote.absent.getRelatedImage().withTintColor(Vote.absent.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Conflict",
                     image: Vote.conflict.getRelatedImage().withTintColor(Vote.conflict.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Abstain",
                     image: Vote.abstain.getRelatedImage().withTintColor(Vote.abstain.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Ineligible",
                     image: Vote.ineligible.getRelatedImage().withTintColor(Vote.ineligible.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "No Vote",
                     image: Vote.noVote.getRelatedImage().withTintColor(Vote.noVote.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { (_) in })
        ])
        let add = UIBarButtonItem(title: "Help", image: UIImage(systemName: "questionmark.circle"), primaryAction: nil, menu: items)
        navigationItem.rightBarButtonItems = [add]
    }
        
    func createResultsMenu() {
        let results = UIMenu(title: "Results", options: .displayInline, children: [
            UIAction(title: "Passed Unanimously",
                     image: UIImage(systemName: "square.fill")!.withTintColor(.systemMint, renderingMode: .alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Passed",
                     image: UIImage(systemName: "square.fill")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal),
                     handler: { (_) in }),
            UIAction(title: "Did not pass",
                     image: UIImage(systemName: "square.fill")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
                     handler: { (_) in }),
        ])
        
        let add = UIBarButtonItem(title: "Help", image: UIImage(systemName: "questionmark.circle"), primaryAction: nil, menu: results)

        navigationItem.rightBarButtonItems = [add]
    }
}
