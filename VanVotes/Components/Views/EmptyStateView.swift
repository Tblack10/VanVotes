//
//  EmptyStateView.swift
//  VanVotes
//
//  Created by Travis Black on 2022-10-22.
//

import Foundation
import UIKit


/// Represents a view with an SF Image and Text above
class EmptyStateView: UIView {

    let messageLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    let logoImageView = UIImageView()
    lazy var imageName: String = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String, pic: TypesOfEmpty){
        super.init(frame: .zero)
        messageLabel.text = message
        imageName = pic.rawValue
        configure()
    }
    
    private func configure() {
        tag = 5
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        
        logoImageView.image = UIImage(systemName: imageName)
        logoImageView.tintColor = .systemGray
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -75),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            logoImageView.topAnchor.constraint(equalTo: self.messageLabel.bottomAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: self.messageLabel.centerXAnchor)
        ])
    }
    

}

enum TypesOfEmpty: String {
    case pencilLine = "pencil.line"
}
