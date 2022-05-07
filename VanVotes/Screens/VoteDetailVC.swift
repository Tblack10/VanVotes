//
//  VoteDetailVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-26.
//

import UIKit


/// Displays details about a Vote
class VoteDetailVC: UIViewController {
    private static let IPHONE_4_SCREEN_SIZE: CGFloat = 670
    
    var voteDetails: Fields? = nil
    var allVotes: [Fields] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray6
        tableView.isScrollEnabled = true
        
        if (UIScreen.main.bounds.height > IPHONE_4_SCREEN_SIZE) {
            tableView.isScrollEnabled = false
            tableView.isUserInteractionEnabled = false
        }
        
        return tableView
    }()
    
    private var agendaDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemBlue
        label.text = "Loading"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
        configureConstraints()
    }
    
}

//MARK: Table View Config
extension VoteDetailVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allVotes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "\(allVotes[indexPath.row].councilMember)"
        
        cell.imageView?.image = Vote(rawValue: allVotes[indexPath.row].vote)?.getRelatedImage()
        cell.imageView?.tintColor = Vote(rawValue: allVotes[indexPath.row].vote)?.getRelatedColour()
        
        return cell
    }
}

//MARK: Constraint Config
extension VoteDetailVC {
    private func configureConstraints() {
        configureAgendaDescriptionLabel()
        configureTableViewConstraints()
    }
    
    private func configureTableViewConstraints() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: agendaDescriptionLabel.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func configureAgendaDescriptionLabel() {
        view.addSubview(agendaDescriptionLabel)
        agendaDescriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        agendaDescriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        agendaDescriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
    }
}

//MARK: Helper Functions and UI
extension VoteDetailVC {
    private func fetchData() {
        Task {
            do {
                let response = try await NetworkManager.shared.getVotes(page: 0, voteId: voteDetails!.voteNumber)
                for record in response.records {
                    allVotes.append(record.record.fields)
                    allVotes = allVotes.sorted { $0.councilMember < $1.councilMember }
                    tableView.reloadData()
                }
            } catch { print(error)}
        }
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemGray6
        self.title = "Vote Breakdown"
        agendaDescriptionLabel.text = voteDetails?.agendaDescription
        tableView.delegate = self
        tableView.dataSource = self
    }
}
