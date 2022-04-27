//
//  VoteDetailCell.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-23.
//

import UIKit

class VoteDetailCell: UITableViewCell {
    
    var cellIdentifier: Int? = nil

    private var model: Fields? = nil

    public static let reuseID = "VoteDetailCell"

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
    }
    
    
    /// Sets the cell UI
    /// - Parameter model: a Field
    func setCell(model: Fields) {
        self.model = model
        checkVoteOutcome()
        checkVote()
        
        imageView?.layer.cornerRadius = 6
        imageView?.backgroundColor = .systemBackground
        
        textLabel?.text = " \n \(model.agendaDescription) \n\n  \(model.voteDate) \n"
    }
    
    
    /// Checks the decision of a vote and displays the appropriate background colour
    private func checkVoteOutcome() {
        if (self.model!.decision == VoteDecision.carriedUnanimously.rawValue) {
            backgroundColor = .systemGreen
        } else if (self.model!.decision == VoteDecision.carried.rawValue){
            backgroundColor = .systemMint
        } else if (self.model!.decision == VoteDecision.lost.rawValue) {
            backgroundColor = .systemRed
        } else {
            backgroundColor = .systemBackground
        }
    }
    
    
    /// Checks an individual councillors vote and displays he appropriate image
    private func checkVote() {
        if (self.model!.vote == Vote.favour.rawValue) {
            imageView?.image = Vote.favour.getRelatedImage()
            imageView?.tintColor = .systemGreen
        } else if (self.model!.vote == Vote.opposition.rawValue){
            imageView?.image = Vote.opposition.getRelatedImage()
            imageView?.tintColor = .systemRed
        } else if (self.model!.vote == Vote.absent.rawValue) {
            imageView?.image = Vote.absent.getRelatedImage()
            imageView?.tintColor = .systemBackground
        } else if (self.model!.vote == Vote.abstain.rawValue) {
            imageView?.image = Vote.abstain.getRelatedImage()
            imageView?.tintColor = .systemBrown
        } else if (self.model!.vote == Vote.conflict.rawValue) {
            imageView?.image = Vote.conflict.getRelatedImage()
            imageView?.tintColor = .systemPink
        }
    }
    


}
