//
//  ViewController.swift
//  rush01
//
//  Created by Paul DESPRES on 1/20/18.
//  Copyright © 2018 42. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark, clear: Bool)
}

protocol SeconViewControllerProtocol {
    func drawItinerary(source: MKMapItem, destination: MKMapItem)
    func dropPinZoomIn(placemark:MKPlacemark, clear: Bool)
}

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, SeconViewControllerProtocol {


    var locManager = CLLocationManager()
    var gps = MKPointAnnotation()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var currentItinerary: MKOverlay? = nil
    
    
    let customItineraryButton: UIButton = {
        let blue = UIColor(red:0.11, green:0.66, blue:0.94, alpha:1.0)
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "itinerary2"), for: .normal)
        button.tintColor = blue
        button.addTarget(self, action: #selector(customItinerary), for: .touchUpInside)
        return button
    }()
    
    let locateMeButton: UIButton = {
        let blue = UIColor(red:0.11, green:0.66, blue:0.94, alpha:1.0)
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "GPS"), for: .normal)
        button.tintColor = blue
        button.addTarget(self, action: #selector(locateMe), for: .touchUpInside)
        return button
    }()
    
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var SegControl: UISegmentedControl!
    @IBAction func segControl(_ sender: Any) {
        switch (SegControl.selectedSegmentIndex) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .hybrid
        }
    }
    
    @objc func customItinerary() {
        let custom = SecondViewController()
        custom.mapView = self.mapView
        custom.delegate = self
        self.navigationController?.pushViewController(custom, animated: true)
    }
    
    @objc func locateMe() {
        let regionRadius: CLLocationDistance = 800
        let coordRegion = MKCoordinateRegionMakeWithDistance(gps.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordRegion, animated: true)
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "itinerary"), for: .normal)
        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    //Will draw directions between current position and selected annotation
    @objc func getDirections(){
        if let selectedPin = self.selectedPin {
            
            //Delete previous itinerary if exists
            if let c = currentItinerary {
                self.mapView.remove(c)
            }

            // Get MKMap Items for drawing
            let sourceMapItem = MKMapItem.forCurrentLocation()
            let destinationMapItem = MKMapItem(placemark: MKPlacemark(coordinate:selectedPin.coordinate, addressDictionary: nil))
            
            drawItinerary(source: sourceMapItem, destination: destinationMapItem)
 
        }
    }
    
    func drawItinerary(source: MKMapItem, destination: MKMapItem) {
        let directionRequest = MKDirectionsRequest()
        
        directionRequest.source = source
        print("self \(self.currentItinerary)")
        directionRequest.destination = destination
        directionRequest.transportType = .any
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(){ (response, error) in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            print(route.polyline.coordinate)
            self.currentItinerary = route.polyline
            self.mapView.add(self.currentItinerary!, level: .aboveRoads)
            //Zoom on the itinerary
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor
        overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 3.0
        return renderer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        locManager.requestWhenInUseAuthorization()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.distanceFilter = 100
        locManager.startUpdatingLocation()
        locateMe()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places or adresses"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
    }

    //Programatically set views
    func setViews() {
        self.view.addSubview(customItineraryButton)
        self.customItineraryButton.rightAnchor.constraint(equalTo: self.SegControl.leftAnchor, constant: -10).isActive = true
        self.customItineraryButton.bottomAnchor.constraint(equalTo: self.SegControl.bottomAnchor).isActive = true
        self.customItineraryButton.topAnchor.constraint(equalTo: self.SegControl.topAnchor).isActive = true
        
        self.view.addSubview(locateMeButton)
        self.locateMeButton.leftAnchor.constraint(equalTo: self.SegControl.rightAnchor, constant: 10).isActive = true
        self.locateMeButton.bottomAnchor.constraint(equalTo: self.SegControl.bottomAnchor).isActive = true
        self.locateMeButton.topAnchor.constraint(equalTo: self.SegControl.topAnchor).isActive = true
        
        
    }

    
    // Update user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        gps.coordinate = locations.last!.coordinate
        mapView.showsUserLocation = true
    }
}

extension ViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark:MKPlacemark, clear: Bool = true){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        if clear == true {
            mapView.removeAnnotations(mapView.annotations)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}
