//
//  NetworkManager.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-17.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://opendata.vancouver.ca/api/v2/catalog/datasets/council-voting-records/records?limit=10&offset=0&timezone=UTC"
    
    private init(){}
    
    func getVotes() async throws -> Response {
        guard let url = URL(string: baseURL) else {
            throw VVError.invalidEndpoint
        }
        
        let(data, _) = try await URLSession.shared.data(from: url)
            
        let response = try JSONDecoder().decode(Response.self, from: data)
        
        return response
    }

}
