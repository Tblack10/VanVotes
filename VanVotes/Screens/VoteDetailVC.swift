//
//  VoteDetailVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-26.
//

import UIKit


/// Displays details about a Vote
class VoteDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray6
        tableView.isScrollEnabled = true
        
        if (UIScreen.main.bounds.height > 670) {
            tableView.isScrollEnabled = false
            tableView.isUserInteractionEnabled = false
        }
        
        return tableView
    }()
    
    var voteDetails: Fields? = nil
    var allVotes: [Fields] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.title = voteDetails?.agendaDescription
        
        Task {
            do {
                let response = try await NetworkManager.shared.getVotes(page: 0, voteId: voteDetails!.voteNumber)
                for record in response.records {
                    allVotes.append(record.record.fields)
                    allVotes = allVotes.sorted { $0.councilMember < $1.councilMember }
//                    print(record.record.fields.decision)
//                    print(record.record.fields.vote)
                    tableView.reloadData()
                }
            } catch { print(error)}
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allVotes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "\(allVotes[indexPath.row].councilMember)"
        
        if (self.allVotes[indexPath.row].vote == Vote.favour.rawValue) {
            cell.imageView?.image = Vote.favour.getRelatedImage()
            cell.imageView?.tintColor = Vote.favour.getRelatedColour()
        } else if (self.allVotes[indexPath.row].vote == Vote.opposition.rawValue){
            cell.imageView?.image = Vote.opposition.getRelatedImage()
            cell.imageView?.tintColor = Vote.opposition.getRelatedColour()
        } else if (self.allVotes[indexPath.row].vote == Vote.absent.rawValue) {
            cell.imageView?.image = Vote.absent.getRelatedImage()
            cell.imageView?.tintColor = Vote.absent.getRelatedColour()
        } else if (self.allVotes[indexPath.row].vote == Vote.abstain.rawValue) {
            cell.imageView?.image = Vote.abstain.getRelatedImage()
            cell.imageView?.tintColor = Vote.abstain.getRelatedColour()
        } else if (self.allVotes[indexPath.row].vote == Vote.conflict.rawValue) {
            cell.imageView?.image = Vote.conflict.getRelatedImage()
            cell.imageView?.tintColor = Vote.conflict.getRelatedColour()
        }
        
        return cell
    }

    
}


