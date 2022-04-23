//
//  VoteDetailCell.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-23.
//

import UIKit

class VoteDetailCell: UITableViewCell {

    public static let reuseID = "VoteDetailCell"
    

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

}
