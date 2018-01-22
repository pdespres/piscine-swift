//
//  Main.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

print("color = Spade | print color.rawValue:")
let color = Color.Spade
print (color.rawValue)
print("\nval = Queen | print val.rawValue:")
let val = Value.Queen
print (val.rawValue)

print("\nNb elements dans allColors:")
print(Color.allColors.count)
print("allColors en rawValue:")
for color in Color.allColors {
    print(color.rawValue)
}

print("\nNb elements dans allValues:")
print(Value.allValues.count)
print("allValues en rawValue:")
for val in Value.allValues {
    print(val.rawValue)
}
