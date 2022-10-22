//
//  PreviousCouncillorsVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-10-22.
//

import Foundation
import UIKit


/// Shows all previous city councillors and mayors (Not active)
class PreviousCouncillorsVC: UIViewController {
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray6
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()

    let tableViewData: [String] = {
        var array: [String] = []
        for person in Councillors.allCases {
            if (!person.getStatus()) {
                array.append(person.rawValue)
            }
        }
        return array
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        self.title = "Previous Councillors and Mayors"
        self.view.backgroundColor = .systemGray6
        
        tableView.delegate = self
        tableView.dataSource = self
        configureConstraints()
    }
    
}

//MARK: UITableView Config
extension PreviousCouncillorsVC: UITableViewDelegate, UITableViewDataSource{
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
extension PreviousCouncillorsVC {
    private func configureConstraints() {
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

}

