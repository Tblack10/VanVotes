//
//  VoteDetailCell.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-23.
//

import UIKit

class VoteDetailCell: UITableViewCell {
    
    var cellIdentifier: Int? = nil
    let largeConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
    
    private var model: Fields? = nil

    public static let reuseID = "VoteDetailCell"

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        textLabel?.numberOfLines = 0
    }
    
    func setCell(model: Fields) {
        self.model = model
        checkVoteOutcome()
        checkVote()
        
        imageView?.layer.cornerRadius = 6
        imageView?.backgroundColor = .systemBackground
        
        textLabel?.text = " \n \(model.agendaDescription) \n\n  \(model.voteDate) \n"
    }
    
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
    
    private func checkVote() {
        if (self.model!.vote == Vote.favour.rawValue) {
            let image = UIImage(systemName: "person.crop.circle.fill.badge.checkmark", withConfiguration: largeConfiguration)
            imageView?.image = image
            imageView?.tintColor = .systemGreen
        } else if (self.model!.vote == Vote.opposition.rawValue){
            imageView?.image = UIImage(systemName: "person.crop.circle.fill.badge.xmark", withConfiguration: largeConfiguration)
            imageView?.tintColor = .systemRed
        } else if (self.model!.vote == Vote.absent.rawValue) {
            let image = UIImage(systemName: "person.crop.circle.badge.questionmark.fill", withConfiguration: largeConfiguration)
            imageView?.image = image
            imageView?.tintColor = .systemBackground
        } else if (self.model!.vote == Vote.abstain.rawValue) {
            imageView?.image = UIImage(systemName: "person.crop.circle.fill.badge.minus", withConfiguration: largeConfiguration)
            imageView?.tintColor = .systemBrown
        } else if (self.model!.vote == Vote.conflict.rawValue) {
            imageView?.image = UIImage(systemName: "aqi.high", withConfiguration: largeConfiguration)
            imageView?.tintColor = .systemPink
        }
    }
    


}
