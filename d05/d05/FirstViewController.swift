//
//  FirstViewController.swift
//  d05
//
//  Created by Paul DESPRES on 1/15/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBAction func segControl(_ sender: Any) {
        switch (segControl.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBAction func bt_loc(_ sender: Any) {
        let regionRadius: CLLocationDistance = 500
        let coordRegion = MKCoordinateRegionMakeWithDistance(gps.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordRegion, animated: true)
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    var locMan = CLLocationManager()
    var gps = MKPointAnnotation()
    var sendFromList: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initOn42()
        locMan.requestWhenInUseAuthorization()
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        locMan.distanceFilter = 100
        locMan.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if sendFromList != nil {
            let regionRadius: CLLocationDistance = 500
            let coordRegion = MKCoordinateRegionMakeWithDistance(spots[sendFromList!].coordinate, regionRadius, regionRadius)
            mapView.setRegion(coordRegion, animated: true)
            sendFromList = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initOn42 () {
//        for i in 0..<spots.count {
//            mapView.addAnnotation(spots[i])
//        }
        mapView.addAnnotations(spots)
        let regionRadius: CLLocationDistance = 200
        let coordRegion = MKCoordinateRegionMakeWithDistance(spots[0].coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Spot else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            view.markerTintColor = annotation.markerTintColor
            view.glyphText = String(annotation.discipline.first!)
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.markerTintColor = annotation.markerTintColor
            view.glyphText = String(annotation.discipline.first!)
//            view.glyphTintColor = UIColor.black
        }
        return view
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        gps.coordinate = locations.last!.coordinate
        mapView.showsUserLocation = true
    }
}
