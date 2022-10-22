//
//  ViewController.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-06.
//

import UIKit

typealias TableDataSource = UITableViewDiffableDataSource<Int, Fields>

/// Displays all votes by a chosen councillor
class CouncillorVotesVC: UIViewController {
    
    //MARK: Class Vars
    var councillor: String? = nil
    var fields: [Fields] = []
    
    //MARK: UI Setup
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.isHidden = true
        ai.color = .systemMint
        return ai
    }()
    
    //MARK: UITableView Setup
    let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VoteDetailCell.self, forCellReuseIdentifier: VoteDetailCell.reuseID)
        
        return tableView
    }()
    
    lazy var datasource: TableDataSource = {
        let datasource = TableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: VoteDetailCell.reuseID, for: indexPath) as! VoteDetailCell
            
            cell.cellIdentifier = Int(self.fields[indexPath.row].voteDetailID)

            if (cell.cellIdentifier == Int(model.voteDetailID)) {
                cell.setCell(model: model)
            }
            
            return cell
        })
        
        return datasource
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        
        //Start Loading Animation
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        
        fetchData(page: 0)
        
        createColourMenu()
    }
    
    
}

//MARK: UITableView
extension CouncillorVotesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (fields.count - 15) == (indexPath.row){
            fetchData(page: indexPath.row)
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
            if (!self.fields.isEmpty) { self.activityIndicator.stopAnimating() }
        }
    }

}

//MARK: Contraint Config
extension CouncillorVotesVC {
    private func configureConstraints() {
        configureTableViewConstraints()
        configureActivityIndicator()
    }
    
    private func configureTableViewConstraints() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

//MARK: Helper Methods
extension CouncillorVotesVC {
    private func fetchData(page: Int) {
        Task {
            do {
                let response = try await NetworkManager.shared.getVotes(page: page, councillor: Councillors(rawValue: councillor!)!)
                
                if (response.records.isEmpty) {
                    activityIndicator.stopAnimating()
                    showEmptyStateView(with: "This member has yet to vote.", with: .pencilLine, in: self.view)
                }
                
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


