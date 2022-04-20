//
//  ErrorMessage.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-20.
//

import Foundation

enum VVError: String, Error {
    case invalidUsername = "This username created an invalid request. Please Try Again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please Try again."
    case invalidData = "The data received from the server was invalid. Please Try Again."
    case invalidEndpoint = "Invalid Endpoint. Please try again"
    case failedToEncode = "Failed to encode the object"
}
