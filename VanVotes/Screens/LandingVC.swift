//
//  LandingVC.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-22.
//

import Foundation
import UIKit

class LandingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .systemGray6
        tableView.isScrollEnabled = false
        return tableView
    }()

    let tableViewData: [String] = {
        var array: [String] = []
        for person in Councillors.allCases {
            array.append(person.rawValue)
        }
        return array
    }()

    override func viewDidLoad() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "VanVotes"
        self.view.backgroundColor = .systemGray6
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = self.tableViewData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableViewData[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = AllVotesVC()
        vc.councillor = tableViewData[indexPath.row]
        navigationController?.show(vc, sender: self)
        
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "VanVotes"
//    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let header = view as? UITableViewHeaderFooterView else { return }
//        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 40)
//        header.textLabel?.frame = header.bounds
//        header.textLabel?.textAlignment = .center
//    }
    
}


