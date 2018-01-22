//
//  File.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

class Deck : NSObject {
    var cards: [Card] = []
    
    static let allSpades: [Card] = Value.allValues.map({Card(color: .Spade, value: $0)})
    static let allHearts: [Card] = Value.allValues.map({Card(color: .Heart, value: $0)})
    static let allDiamonds: [Card] = Value.allValues.map({Card(color: .Diamond, value: $0)})
    static let allClubs: [Card] = Value.allValues.map({Card(color: .Club, value: $0)})
    
    static let allCards: [Card] = allSpades + allHearts + allDiamonds + allClubs
}
