//
//  NetworkManager.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-17.
//

import Foundation


/// Requests made to APIs
struct NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://opendata.vancouver.ca/api/v2/catalog/datasets/council-voting-records/"
    
    private init(){}
    
    
    /// Gets all votes, ordered by date of vote and vote number (desc)
    /// - Parameter page: the offeset of results to fetch from, as an Int
    /// - Returns: A Response
    func getVotes(page: Int) async throws -> Response {
        let urlString = baseURL + "records?order_by=vote_date%20desc%2C%20vote_number%20desc&limit=100&offset=\(page)&timezone=UTC"
        guard let url = URL(string: urlString) else {
            throw VVError.invalidEndpoint
        }
        
        let(data, _) = try await URLSession.shared.data(from: url)
            
        let response = try JSONDecoder().decode(Response.self, from: data)
        
        return response
    }
    
    
    /// Gets all votes by a particular Councillor, ordered by date of vote and vote number (desc)
    /// - Parameters:
    ///   - page: the offeset of results to fetch from, as an Int
    ///   - councillor: the name of the councillor to fetch the votes from, as a String. (Can be found in Councillors enum)
    /// - Returns: A Response object
    func getVotes(page: Int, councillor: Councillors) async throws -> Response {
        let name = councillor.urlSafeName().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = baseURL + "records?order_by=vote_date%20desc%2C%20vote_number%20desc&limit=30&offset=\(page)&timezone=UTC&where=council_member%3D%27\(name)%27"

        guard let url = URL(string: urlString) else {
            throw VVError.invalidEndpoint
        }
        
        
        let(data, _) = try await URLSession.shared.data(from: url)
            
        let response = try JSONDecoder().decode(Response.self, from: data)
        
        return response
    }

    
    /// Gets the results of one individual vote for each councillor
    /// - Parameters:
    ///   - page: the offeset of results to fetch from, as an Int
    ///   - voteId: the id of the vote, as an Int
    /// - Returns: A Response object
    func getVotes(page: Int, voteId: Int) async throws -> Response {
        let urlString = baseURL + "records?order_by=vote_date%20desc%2C%20vote_number%20desc&limit=30&offset=\(page)&timezone=UTC&where=vote_number%3D\(voteId)"
        
        guard let url = URL(string: urlString) else {
            throw VVError.invalidEndpoint
        }
        
        let(data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(Response.self, from: data)
        
        return response
    }
}
