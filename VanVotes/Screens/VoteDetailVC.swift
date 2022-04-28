//
//  VoteDetailVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-26.
//

import UIKit


/// Displays details about a Vote
class VoteDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
        configureConstraints()
    }
    
}

//MARK: Table View Config
extension VoteDetailVC {
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
        configureTableViewConstraints()
    }
    
    private func configureTableViewConstraints() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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
        self.title = voteDetails?.agendaDescription
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}
