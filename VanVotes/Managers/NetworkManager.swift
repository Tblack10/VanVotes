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
    private let tokenBaseURL = "https://hammerhead-app-xmwe7.ondigitalocean.app"

    private init(){}
    
    //MARK: Votes Network Calls
    
    /// Gets all votes, ordered by date of vote and vote number (desc)
    /// - Parameter page: the offeset of results to fetch from, as an Int
    /// - Returns: A Response
    func getVotes(page: Int) async throws -> Response {
        let urlString = baseURL + "records?order_by=vote_date%20desc%2C%20vote_number%20desc&limit=100&offset=\(page)&timezone=UTC"
        guard let url = URL(string: urlString) else {
            throw VVError.invalidEndpoint
        }
        
        let(data, _) = try await URLSession.shared.data(from: url)
        let str = String(decoding: data, as: UTF8.self)
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

//MARK: Token Network Calls
extension NetworkManager {
    
    /// Sends a APN Token to the serever to be stored
    /// - Parameter id: the id of the APN
    /// - Returns: a 201 if successfull, or a failedToEncodee if unsuccessful
    func storeToken(_ id: String) async throws -> Int {
        guard let url = URL(string: "\(tokenBaseURL)/token") else {
            throw VVError.invalidEndpoint
        }
        
        let json = [
                   "apn_token": id,
               ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
            throw VVError.failedToEncode
        }
            
        return 201
    }
}
