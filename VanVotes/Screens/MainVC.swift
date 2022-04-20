//
//  ViewController.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-06.
//

import UIKit

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let response = try await NetworkManager.shared.getVotes()

                for record in response.records {
                    
                    print(record.record.fields.councilMember)
                    print(record.record.fields.vote)
                    print(record.record.fields.agendaDescription)
                    print(record.record.fields.voteNumber)
                    print(record.record.fields.voteDetailID)
                    
                    print("----------------------------------------------------")
                }
                
            } catch {
                print(error)
            }
        }
        
    }
    
    
    
}
