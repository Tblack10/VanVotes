//
//  ViewController.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-06.
//

import UIKit

typealias TableDataSource = UITableViewDiffableDataSource<Int, Fields>

class AllVotesVC: UIViewController, UITableViewDelegate {
    
    var councillor: String? = nil
    
    let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VoteDetailCell.self, forCellReuseIdentifier: VoteDetailCell.reuseID)
        
        return tableView
    }()
    
    var fields: [Fields] = []
    
    lazy var datasource: TableDataSource = {
        let datasource = TableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: VoteDetailCell.reuseID, for: indexPath)
            
            //TODO: Turn vote statuses into an enum -> Return UIColour
            if (model.vote == "In Favour") {
                cell.backgroundColor = .systemMint
            } else if (model.vote == "In Opposition"){
                cell.backgroundColor = .systemRed
            } else if (model.vote == "Absent") {
                cell.backgroundColor = .systemBrown
            } else if (model.vote == "Abstain") {
                cell.backgroundColor = .systemPink
            }
            
            cell.textLabel?.text = " \(model.agendaDescription) \n \(model.vote) \n \(model.decision) \n \(model.meetingType) \n \(model.voteDate)"
            cell.textLabel?.numberOfLines = 0
            return cell
        })
        
        return datasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        Task {
            do {
                let response = try await NetworkManager.shared.getVotes(page: 0, councillor: Councillors(rawValue: councillor!)!)
                
                for record in response.records {
                    fields.append(record.record.fields)
                    updateData(on: fields)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (fields.count - 15) == (indexPath.row){
            Task {
                do {
                    let response = try await NetworkManager.shared.getVotes(page: indexPath.row)

                    for record in response.records {
                        fields.append(record.record.fields)
                        updateData(on: fields)
                    }

                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    
    func updateData(on field:  [Fields]) {
        var snapshot = datasource.snapshot()
        if(snapshot.numberOfSections == 0) {
            snapshot.appendSections([0])
        }
        snapshot.appendItems(fields)
        DispatchQueue.main.async {
            self.datasource.apply(snapshot, animatingDifferences: false)
        }
    }
    
}
