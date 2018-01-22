//
//  Form.swift
//  d06
//
//  Created by Paul DESPRES on 1/16/18.
//  Copyright © 2018 42. All rights reserved.
//

import Foundation
import UIKit

class Form: UIView {
    
    var type: String = "Rectangle"
    var collisionType: UIDynamicItemCollisionBoundsType = .rectangle
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return collisionType
    }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        if (arc4random_uniform(2) == 0) {
            type = "Circle"
        }
        switch(arc4random_uniform(4)) {
        case 0:
            backgroundColor = UIColor.lightGray
        case 1:
            backgroundColor = UIColor.green
        case 2:
            backgroundColor = UIColor.blue
        case 3:
            backgroundColor = UIColor.yellow
        default:
            backgroundColor = UIColor.black
        }
    }

    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            if (self.type == "Circle") {
                layer.cornerRadius = newBounds.size.width / 2.0
                self.collisionType = .ellipse
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//class Form: UIView {
//    var touchViews = [UITouch:TouchSpotView]()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        isMultipleTouchEnabled = true
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        isMultipleTouchEnabled = true
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            createViewForTouch(touch: touch)
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let view = viewForTouch(touch: touch)
//            // Move the view to the new location.
//            let newLocation = touch.location(in: self)
//            view?.center = newLocation
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for touch in touches {
////            removeViewForTouch(touch: touch)
////        }
//    }
//    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for touch in touches {
////            removeViewForTouch(touch: touch)
////        }
//    }
//    
//    func createViewForTouch( touch : UITouch ) {
//        let newView = TouchSpotView()
//        newView.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
//        newView.center = touch.location(in: self)
//        
//        // Add the view and animate it to a new size.
//        addSubview(newView)
//        UIView.animate(withDuration: 0.2) {
//            newView.bounds.size = CGSize(width: 100, height: 100)
//        }
//        
//        // Save the views internally
//        touchViews[touch] = newView
//    }
//    
//    func viewForTouch (touch : UITouch) -> TouchSpotView? {
//        return touchViews[touch]
//    }
//    
//    func removeViewForTouch (touch : UITouch ) {
//        if let view = touchViews[touch] {
//            view.removeFromSuperview()
//            touchViews.removeValue(forKey: touch)
//        }
//    }
//}
//
//class TouchSpotView : UIView {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        switch(arc4random_uniform(4)) {
//        case 0:
//            backgroundColor = UIColor.lightGray
//        case 1:
//            backgroundColor = UIColor.green
//        case 2:
//            backgroundColor = UIColor.blue
//        case 3:
//            backgroundColor = UIColor.yellow
//        default:
//            backgroundColor = UIColor.black
//        }
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // Update the corner radius when the bounds change.
//    override var bounds: CGRect {
//        get { return super.bounds }
//        set(newBounds) {
//            super.bounds = newBounds
//            if (arc4random_uniform(2) == 0) {
//                layer.cornerRadius = newBounds.size.width / 2.0
//            }
//        }
//    }
//}


