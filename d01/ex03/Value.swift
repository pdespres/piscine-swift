//
//  Value.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

enum Value : Int {
    case Ace = 1
    case Two
    case Three
    case Four = 4
    case Five = 5
    case Six = 6
    case Seven = 7
    case Eight = 8
    case Nine = 9
    case Ten = 10
    case Jack = 11
    case Queen = 12
    case King = 13
    
    static let allValues = [Ace,Two,Three,Four,Five,Six,Seven,Eight,Nine,Ten,Jack,Queen,King]
}
