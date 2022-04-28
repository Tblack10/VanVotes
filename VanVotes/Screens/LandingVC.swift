//
//  LandingVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-22.
//

import Foundation
import UIKit


/// Initial VC viewed by a user
class LandingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private static let IPHONE_4_SCREEN_SIZE: CGFloat = 670
    
    lazy var allVotesButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "View All Votes"
        config.baseBackgroundColor = .systemMint
        
        let button = UIButton(configuration: config,
          primaryAction: UIAction() { _ in
            let vc = VotesVC()
            UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
            self.navigationController?.show(vc, sender: self)
           })
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray6
        
        //TODO: Move this into an extension (UIScreen)
        if (UIScreen.main.bounds.height > IPHONE_4_SCREEN_SIZE) {
            tableView.isScrollEnabled = false
        }
        
        return tableView
    }()

    let tableViewData: [String] = {
        var array: [String] = []
        for person in Councillors.allCases {
            array.append(person.rawValue)
        }
        return array
    }()

    override func viewDidLoad() {
        view.addSubview(tableView)
        view.addSubview(allVotesButton)
        
        self.title = "VanVotes"
        self.view.backgroundColor = .systemGray6
        
        tableView.delegate = self
        tableView.dataSource = self
        
        allVotesButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        allVotesButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        allVotesButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        allVotesButton.heightAnchor.constraint(equalToConstant: 39).isActive = true
        tableView.topAnchor.constraint(equalTo: self.allVotesButton.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = self.tableViewData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = CouncillorVotesVC()
        vc.title = "\(tableViewData[indexPath.row])"
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true

        vc.councillor = tableViewData[indexPath.row]
        navigationController?.show(vc, sender: self)
        
    }
    
}


