//
//  Card.swift
//  
//
//  Created by Paul DESPRES on 1/9/18.
//

import Foundation

class Card : NSObject {
    var color: Color
    var value: Value
    
    init(color: Color, value: Value) {
        self.color = color
        self.value = value
    }
    
    override var description: String {
        get { return "\(self.value) of \(self.color)" }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return color == object.color && value == object.value
        } else {
            return false
        }
    }
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.isEqual(rhs)
}
