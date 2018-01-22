//
//  main.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

let deck = Deck()
for card in Deck.allCards {
    deck.cards.append(card)
}
print(deck.cards)
deck.cards.shuffle()
print("\nOn melange le deck -> appel a la methode shuffle de Array\n")
print(deck.cards)
