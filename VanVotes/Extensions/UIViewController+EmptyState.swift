//
//  EmptyState+String.swift
//  VanVotes
//
//  Created by Travis Black on 2022-10-22.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Displays an empty state view if no items exist
    /// - Parameters:
    ///   - message: The message you want to display
    ///   - pic: The pic to display under the message as a TypesOfEmpty
    ///   - view: The view in which to display the empty message and image
    func showEmptyStateView(with message: String,with pic: TypesOfEmpty, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message, pic: pic)
        view.addSubview(emptyStateView)
        emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        emptyStateView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
