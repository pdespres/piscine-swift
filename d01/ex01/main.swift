//
//  main.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

print("card1: instance d'un Ace of Spade")
let card1 = Card(color:.Spade, value:.Ace)
print("card2: instance d'un Ace of Spade")
let card2 = Card(color:.Spade, value:.Ace)
print("card3: instance d'un Ace of Heart")
let card3 = Card(color:.Heart, value:.Ace)
print("\ncard1.description:")
print(card1.description)
print("\ncard1 isEqual card2?:")
print(card1.isEqual(card2))
print("card1 isEqual card3?:")
print(card1.isEqual(card3))
print("\ncard1 == card2?:")
print(card1 == card2)
print("card1 == card3?:")
print(card1 == card3)
