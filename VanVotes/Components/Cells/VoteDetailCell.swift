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
        
        textLabel?.text = " \n \(model.agendaDescription) \n\n  \(model.voteDate) \n\n \(model.meetingType) \n"
    }
    
    
    func setCellNoImage(model: Fields) {
        self.model = model
        checkVoteOutcome()
        
        imageView?.layer.cornerRadius = 6
        imageView?.backgroundColor = .systemBackground
        
        textLabel?.text = " \n \(model.agendaDescription) \n\n  \(model.voteDate) \n\n \(model.meetingType) \n"
    }
    
    
    /// Checks the decision of a vote and displays the appropriate background colour
    private func checkVoteOutcome() {
        backgroundColor = VoteDecision(rawValue: self.model!.decision)?.getRelatedColour()
    }
    
    
    /// Checks an individual councillors vote and displays he appropriate image
    private func checkVote() {
        imageView?.image = Vote(rawValue: self.model!.vote)?.getRelatedImage()
        imageView?.tintColor = Vote(rawValue: self.model!.vote)?.getRelatedColour()
    }
    


}
