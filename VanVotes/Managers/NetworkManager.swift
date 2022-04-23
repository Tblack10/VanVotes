//
//  NetworkManager.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-17.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://opendata.vancouver.ca/api/v2/catalog/datasets/council-voting-records/"
    
    private init(){}
    
    func getVotes(page: Int) async throws -> Response {
        let urlString = baseURL + "records?order_by=vote_date%20desc%2C%20vote_number%20desc&limit=30&offset=\(page)&timezone=UTC"
        guard let url = URL(string: urlString) else {
            throw VVError.invalidEndpoint
        }
        
        let(data, _) = try await URLSession.shared.data(from: url)
            
        let response = try JSONDecoder().decode(Response.self, from: data)
        
        return response
    }
    
    func getVotes(page: Int, councillor: Councillors) async throws -> Response {
        let name = councillor.urlSafeName().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = baseURL + "records?vote_date%20desc%2C%20vote_number%20desc&limit=30&offset=\(page)&timezone=UTC&where=council_member%3D%27\(name)%27"

        guard let url = URL(string: urlString) else {
            throw VVError.invalidEndpoint
        }
        
        
        let(data, _) = try await URLSession.shared.data(from: url)
            
        let response = try JSONDecoder().decode(Response.self, from: data)
        
        return response
    }

}
