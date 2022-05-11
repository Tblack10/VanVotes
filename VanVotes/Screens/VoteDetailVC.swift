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
    
    //MARK: Table View Setup
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
    
    //MARK: UI Setup
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .large)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.isHidden = true
        ai.color = .systemMint
        return ai
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
        configureConstraints()
        configureUI()
        fetchData()
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        

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
        configureActivityIndicator()
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
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
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
                    activityIndicator.stopAnimating()
                    tableView.reloadData()
                }
            } catch { print(error) }
        }
    }
    
    
    /// Misc UI Setup
    private func configureUI() {
        self.view.backgroundColor = .systemGray6
        self.title = "Vote Breakdown"
        agendaDescriptionLabel.text = voteDetails?.agendaDescription
        tableView.delegate = self
        tableView.dataSource = self
        createMenu()
    }
    
    
    /// Creates the help menu for the people icons
    func createMenu() {
        let items = UIMenu(title: "Help", options: .displayInline, children: [
            UIAction(title: "Favour",
                     image: Vote.favour.getRelatedImage().withTintColor(Vote.favour.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { [weak self] (action) in }),
            UIAction(title: "Opposition",
                     image: Vote.opposition.getRelatedImage().withTintColor(Vote.opposition.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { [weak self] (action) in }),
            UIAction(title: "Absent",
                     image: Vote.absent.getRelatedImage().withTintColor(Vote.absent.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { [weak self] (action) in }),
            UIAction(title: "Conflict",
                     image: Vote.conflict.getRelatedImage().withTintColor(Vote.conflict.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { [weak self] (action) in }),
            UIAction(title: "Abstain",
                     image: Vote.abstain.getRelatedImage().withTintColor(Vote.abstain.getRelatedColour()).withRenderingMode(.alwaysOriginal),
                     handler: { [weak self] (action) in })
        ])
        
        let add = UIBarButtonItem(title: "Help", image: UIImage(systemName: "questionmark.circle"), primaryAction: nil, menu: items)
        navigationItem.rightBarButtonItems = [add]
    }
}
