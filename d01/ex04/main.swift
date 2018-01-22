//
//  main.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

let deck = Deck(shuffle: false)
print(deck)
print("\nOn tire 5 cartes")
print(deck.draw() ?? "No more cards!")
print(deck.draw() ?? "No more cards!")
print(deck.draw() ?? "No more cards!")
print(deck.draw() ?? "No more cards!")
print(deck.draw() ?? "No more cards!")
print("\nLe deck restant:")
print(deck)
print("\nLes cartes en mains: (outs)")
print(deck.outs)
print("\nOn change 3 cartes (3 * fold())")
print("discards et outs:")
deck.fold(c: deck.outs[4])
deck.fold(c: deck.outs[0])
deck.fold(c: deck.outs[2])
print(deck.discards)
print(deck.outs)
