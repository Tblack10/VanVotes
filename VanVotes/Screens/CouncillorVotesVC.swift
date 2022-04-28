//
//  ViewController.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-06.
//

import UIKit

typealias TableDataSource = UITableViewDiffableDataSource<Int, Fields>


/// Displays all votes by a chosen councillor
class CouncillorVotesVC: UIViewController, UITableViewDelegate {
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: VoteDetailCell.reuseID, for: indexPath) as! VoteDetailCell
            
            cell.cellIdentifier = self.fields[indexPath.row].voteDetailID

            if (cell.cellIdentifier == model.voteDetailID) {
                cell.setCell(model: model)
            }
            
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
                    let response = try await NetworkManager.shared.getVotes(page: indexPath.row, councillor: Councillors(rawValue: councillor!)!)

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = VoteDetailVC()
        vc.title = "\(fields[indexPath.row])"
        vc.voteDetails = fields[indexPath.row]
        
        navigationController?.show(vc, sender: self)
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
