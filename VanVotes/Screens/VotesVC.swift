//
//  VotesVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-28.
//

import UIKit

/// Displays ALL votes
class VotesVC: UIViewController {
    
    //MARK: Pagination
    /// Number of API fetches that have been made -> multiply this by limit for pagination
    private var counter: Int = 0
    /// The number of results that have been fetched but not added to fields -> used for pagination
    private var notAdded: Int = 0
    /// The maximum number of results that can be fetched from the API per fetch
    private let API_FETCH_LIMIT = 100
    
    //MARK: Variables
    /// An array of all the votes that have been fetched
    var fields: [Fields] = []
    
    
    // MARK: Table View Setup
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(VoteDetailCell.self, forCellReuseIdentifier: VoteDetailCell.reuseID)
        tableView.delegate = self
        return tableView
    }()
    
    lazy var datasource: TableDataSource = {
        let datasource = TableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: VoteDetailCell.reuseID, for: indexPath) as! VoteDetailCell
            
            cell.cellIdentifier = self.fields[indexPath.row].voteDetailID

            if (cell.cellIdentifier == model.voteDetailID) {
                cell.setCellNoImage(model: model)

            }
            
            return cell
        })
        
        return datasource
    }()
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Council Agendas"
        configureTableViewConstraints()
        fetchVotes()
    }
    
}

//MARK: TableView Setup
extension VotesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if ((counter*API_FETCH_LIMIT) - notAdded) == (indexPath.row + 1){
            fetchVotes()
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

//MARK: Constraints
extension VotesVC {
    private func configureConstraints() {
        configureTableViewConstraints()
    }
    
    private func configureTableViewConstraints() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

//MARK: Helper Methods
extension VotesVC {    
    private func fetchVotes() {
        Task {
            do {
                let response = try await NetworkManager.shared.getVotes(page: counter*API_FETCH_LIMIT)
                counter += 1
                for record in response.records {
                    let doesContain = fields.contains {
                        $0.agendaDescription == record.record.fields.agendaDescription
                    }
                    
                    if (!doesContain) {
                        fields.append(record.record.fields)
                        updateData(on: fields)
                    } else {
                        notAdded += 1
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
