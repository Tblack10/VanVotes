//
//  Councillor.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-17.
//

import Foundation


/// All Councillors and Mayors on the council
enum Councillors: String, CaseIterable {
    //2022 - Present
    case sarahKirbyYung = "Councillor Sarah Kirby-Yung"
    case lisaDominato = "Councillor Lisa Dominato"
    case brianMontague = "Councillor Brian Montague"
    case mikeKlassen = "Councillor Mike Klassen"
    case peterMeiszner = "Councillor Peter Meiszner"
    case rebeccaBligh = "Councillor Rebecca Bligh"
    case lennyZhou = "Councillor Lenny Zhou"
    case adrianeCarr = "Councillor Adriane Carr"
    case christineBoyle = "Councillor Christine Boyle"
    case peteFry = "Councillor Pete Fry"
    case kenSim = "Mayor Ken Sim"

    //2018 - 2022 Council
    case melissaDeGenova = "Councillor Melissa De Genova"
    case colleenHardwick = "Councillor Colleen Hardwick"
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
            // 2022 - Present
        case .rebeccaBligh:
            return "Councillor R Bligh"
        case .christineBoyle:
            return "Councillor C Boyle"
        case .adrianeCarr:
            return "Councillor A Carr"
        case .lisaDominato:
            return "Councillor L Dominato"
        case .peteFry:
            return "Councillor P Fry"
        case .sarahKirbyYung:
            return "Councillor S Kirby-Yung"
        case .brianMontague:
            return "Councillor B Montague"
        case .mikeKlassen:
            return "Councillor M Klassen"
        case .peterMeiszner:
            return "Councillor P Meiszner"
        case .lennyZhou:
            return "Councillor L Zhou"
        case .kenSim:
            return "Mayor K Sim"
            
            // 2018-2022 Council
        case .melissaDeGenova:
            return "Councillor M De Genova"
        case .colleenHardwick:
            return "Councillor C Hardwick"
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
            // 2022 - Present Council
        case .brianMontague:
            return true
        case .mikeKlassen:
            return true
        case .peterMeiszner:
            return true
        case .lennyZhou:
            return true
        case .kenSim:
            return true
        case .rebeccaBligh:
            return true
        case .christineBoyle:
            return true
        case .adrianeCarr:
            return true
        case .peteFry:
            return true
        case .lisaDominato:
            return true
        case .sarahKirbyYung:
            return true
            
            // 2018-2022 Council
        case .melissaDeGenova:
            return false
        case .colleenHardwick:
            return false
        case .jeanSwanson:
            return false
        case .michaelWiebe:
            return false
        case .kennedyStewart:
            return false
            
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
