//
//  ViewController.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-06.
//

import UIKit

typealias TableDataSource = UITableViewDiffableDataSource<Int, Fields>

class MainVC: UIViewController {
    
    let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")

        return tableView
    }()
    var fields: [Fields] = []
    
    lazy var datasource: TableDataSource = {
        let datasource = TableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = String(model.voteDetailID)
            return cell
        })
        
        return datasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        Task {
            do {
                let response = try await NetworkManager.shared.getVotes()
                
                for record in response.records {
                    
                    print(record.record.fields.councilMember)
                    print(record.record.fields.vote)
                    print(record.record.fields.agendaDescription)
                    print(record.record.fields.voteNumber)
                    print(record.record.fields.voteDate)
                    
                    print("----------------------------------------------------")
                    fields.append(record.record.fields)
                    updateData(on: fields)

                }
                
                
            } catch {
                print(error)
            }
        }
        
    }
    
    
    
    func updateData(on field:  [Fields]) {
        var snapshot = datasource.snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(fields)
        DispatchQueue.main.async {
            self.datasource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}
