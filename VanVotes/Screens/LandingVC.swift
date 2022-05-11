//
//  LandingVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-22.
//

import Foundation
import UIKit


/// Initial VC viewed by a user
class LandingVC: UIViewController {
    // MARK: Constants
    private static let IPHONE_8PLUS_SCREEN_SIZE:CGFloat = 736
    private let VOTEBUTTON_SIDE_INSETS:CGFloat = 50
    private let VOTEBUTTON_TOP_INSET:CGFloat = 20
    private let TABLEVIEW_SIDE_INSETS:CGFloat = 30
    private let TABLEVIEW_TOP_INSET:CGFloat = 0
    private let TABLEVIEW_BOTTOM_INSET: CGFloat = -50
    
    // MARK: UI
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
        tableView.showsVerticalScrollIndicator = false
        
        //TODO: Move this into an extension (UIScreen)
        if (UIScreen.main.bounds.height > IPHONE_8PLUS_SCREEN_SIZE) {
            tableView.isScrollEnabled = false
        }
        
        return tableView
    }()

    let tableViewData: [String] = {
        var array: [String] = []
        for person in Councillors.allCases {
            if (person.getStatus()) {
                array.append(person.rawValue)
            }
        }
        return array
    }()

    //MARK: ViewDidLoad
    override func viewDidLoad() {
        configureUI()
        configureConstraints()
    }
    
}

//MARK: UITableView Config
extension LandingVC: UITableViewDelegate, UITableViewDataSource{
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

//MARK: Constraint Config
extension LandingVC {
    private func configureConstraints() {
        configureVoteButtonConstraints()
        configureTableViewConstraints()
    }
    
    private func configureVoteButtonConstraints() {
        view.addSubview(allVotesButton)
        allVotesButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: VOTEBUTTON_TOP_INSET).isActive = true
        allVotesButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: VOTEBUTTON_SIDE_INSETS).isActive = true
        allVotesButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -VOTEBUTTON_SIDE_INSETS).isActive = true
        allVotesButton.heightAnchor.constraint(equalToConstant: 39).isActive = true
    }
    
    private func configureTableViewConstraints() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.allVotesButton.bottomAnchor, constant: TABLEVIEW_TOP_INSET).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: TABLEVIEW_SIDE_INSETS).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -TABLEVIEW_SIDE_INSETS).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: TABLEVIEW_BOTTOM_INSET).isActive = true
    }
}

//MARK: UI Config
extension LandingVC {
    private func configureUI() {
        self.title = "VanVotes"
        self.view.backgroundColor = .systemGray6
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}
