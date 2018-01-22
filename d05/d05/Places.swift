//
//  Places.swift
//  d05
//
//  Created by Paul DESPRES on 1/15/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import Foundation
import MapKit

var spots : [Spot] = [
    Spot(title:"42", subtitle:"Heaven or hell", locationName:"Ecole 42", discipline:"School", coordinate:CLLocationCoordinate2D(latitude: 48.8966037, longitude: 2.3184669)),
    Spot(title:"Tokyo", subtitle:"Familly's grounds", locationName:"Tokyo", discipline:"Ville", coordinate:CLLocationCoordinate2D(latitude: 35.6730185, longitude: 139.4302149)),
    Spot(title:"Home", subtitle:"Home sweet home", locationName:"26 rue de Meaux", discipline:"Adresse", coordinate:CLLocationCoordinate2D(latitude: 48.8799884, longitude: 2.3703745))]

class Spot: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, subtitle: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
    
    var markerTintColor: UIColor  {
        switch self.discipline {
        case "School":
            return .red
        case "Ville":
            return .green
        case "Adresse":
            return .blue
        case "2":
            return .purple
        default:
            return .cyan
        }
    }
}
