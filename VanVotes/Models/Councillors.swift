//
//  Councillor.swift
//  VanVotes
//
//  Created by Travis Black on 2022-04-17.
//

import Foundation


/// All Councillors and Mayors on the council
enum Councillors: String, CaseIterable {
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
    
    func urlSafeName () -> String {
        switch self {
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
        }
    }
}
