//
//  File.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

class Deck : NSObject {
    var cards: [Card] = []
    var discards: [Card] = []
    var outs: [Card] = []
    
    init(shuffle: Bool) {
        for card in Deck.allCards {
            self.cards.append(card)
        }
        if shuffle {
            self.cards.shuffle()
        }
    }
    
    override var description: String {
        get { return (self.cards.map({$0.description}).joined(separator: ", ")) }
    }
    
    func draw() -> Card? {
        if cards.count > 0 {
            outs.append(cards[0])
            cards.remove(at: 0)
            return outs.last!
        } else {
            return nil
        }
    }
    
    func fold(c: Card) {
        let index = outs.index(of: c)
        if index != nil {
            discards.append(c)
            outs.remove(at: index!)
        }
    }
    
    static let allSpades: [Card] = Value.allValues.map({Card(color: .Spade, value: $0)})
    static let allHearts: [Card] = Value.allValues.map({Card(color: .Heart, value: $0)})
    static let allDiamonds: [Card] = Value.allValues.map({Card(color: .Diamond, value: $0)})
    static let allClubs: [Card] = Value.allValues.map({Card(color: .Club, value: $0)})
    
    static let allCards: [Card] = allSpades + allHearts + allDiamonds + allClubs
}

extension Array {
    mutating func shuffle() {
        for (i, _) in self.enumerated() {
            swapAt(i, Int(arc4random_uniform(UInt32(self.count))))
        }
    }
}
