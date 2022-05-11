//
//  Councillor.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-17.
//

import Foundation


/// All Councillors and Mayors on the council
enum Councillors: String, CaseIterable {
    //2018 - 2022 Council
    case rebeccaBligh = "Councillor Rebecca Bligh"
    case christineBoyle = "Councillor Christine Boyle"
    case adrianeCarr = "Councillor Adriane Carr"
    case melissaDeGenova = "Councillor Melissa De Genova"
    case lisaDominato = "Councillor Lisa Dominato"
    case peteFry = "Councillor Pete Fry"
    case colleenHardwick = "Councillor Colleen Hardwick"
    case sarahKirbyYung = "Councillor Sarah Kirby-Yung"
    case jeanSwanson = "Councillor Jean Swanson"
    case michaelWiebe = "Councillor Michael Wiebe"
    case kennedyStewart = "Mayor Kennedy Stewart"
    
    // 2014 - 2018 Council
    case georgeAffleck = "Councillor George Affleck"
    case elizabethBall = "Councillor Elizabeth Ball"
    case hectorBremner = "Councillor Hector Bremner"
    case heatherDeal = "Councillor Heather Deal"
    case kerryJang = "Councillor Kerry Jang"
    case raymondLouie = "Councillor Raymond Louie"
    case geoffMeggs = "Councillor Geoff Meggs"
    case andreaReimer = "Councillor Andrea Reimer"
    case timStevenson = "Councillor Tim Stevenson"
    case gregorRobertson = "Mayor Gregor Robertson"
    
    
    /// Converts a councillors name into the appropriate name used by the API
    /// - Returns: A councillors name ready to be used by the API, as a string
    func urlSafeName () -> String {
        switch self {
            // 2018-2022 Council
        case .rebeccaBligh:
            return "Councillor R Bligh"
        case .christineBoyle:
            return "Councillor C Boyle"
        case .adrianeCarr:
            return "Councillor A Carr"
        case .melissaDeGenova:
            return "Councillor M De Genova"
        case .lisaDominato:
            return "Councillor L Dominato"
        case .peteFry:
            return "Councillor P Fry"
        case .colleenHardwick:
            return "Councillor C Hardwick"
        case .sarahKirbyYung:
            return "Councillor S Kirby-Yung"
        case .jeanSwanson:
            return "Councillor J Swanson"
        case .michaelWiebe:
            return "Councillor M Wiebe"
        case .kennedyStewart:
            return "Mayor K Stewart"
            
            // 2014-2018 Council
        case .georgeAffleck:
            return "Councillor G Affleck"
        case .elizabethBall:
            return "Councillor E Ball"
        case .hectorBremner:
            return "Councillor H Bremner"
        case .heatherDeal:
            return "Councillor H Deal"
        case .kerryJang:
            return "Councillor K Jang"
        case .raymondLouie:
            return "Councillor R Louie"
        case .geoffMeggs:
            return "Councillor G Meggs"
        case .andreaReimer:
            return "Councillor A Reimer"
        case .timStevenson:
            return "Councillor T Stevenson"
        case .gregorRobertson:
            return "Mayor G Robertson"
        }
    }
    
    
    /// Gets the current status of a councillor
    /// - Returns: A boolean represent the status of the councillor, true is active, false is inactive
    func getStatus () -> Bool {
        switch self {
            // 2018-2022 Council
        case .rebeccaBligh:
            return true
        case .christineBoyle:
            return true
        case .adrianeCarr:
            return true
        case .melissaDeGenova:
            return true
        case .lisaDominato:
            return true
        case .peteFry:
            return true
        case .colleenHardwick:
            return true
        case .sarahKirbyYung:
            return true
        case .jeanSwanson:
            return true
        case .michaelWiebe:
            return true
        case .kennedyStewart:
            return true
            
            // 2014-2018 Council
        case .georgeAffleck:
            return false
        case .elizabethBall:
            return false
        case .hectorBremner:
            return false
        case .heatherDeal:
            return false
        case .kerryJang:
            return false
        case .raymondLouie:
            return false
        case .geoffMeggs:
            return false
        case .andreaReimer:
            return false
        case .timStevenson:
            return false
        case .gregorRobertson:
            return false
        }
    }
    
}
