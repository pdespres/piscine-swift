//
//  ViewController.swift
//  itinerary
//
//  Created by Jordan MUNOZ on 1/20/18.
//  Copyright © 2018 Jordan MUNOZ. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var searchBarSource : UISearchBar?
    var searchBarDestination : UISearchBar?
    var tableResults: UITableView?
    var mapView: MKMapView?
    var matchingItems: [MKMapItem] = []
    var delegate: SeconViewControllerProtocol?
    var activeSearchBar: Int = 0
    var itinerarySource: MKMapItem? = nil
    var itineraryDestination: MKMapItem? = nil
    var placeSource: MKPlacemark?
    var placeDestination: MKPlacemark?
    
    var goButton: UIButton = {
        let blue = UIColor(red:0.11, green:0.66, blue:0.94, alpha:1.0)
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitle("Go!", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(calculateItinerary), for: .touchUpInside)
        return button
    }()
    
    let revertButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red:0.11, green:0.66, blue:0.94, alpha:1.0)
        button.setImage(UIImage(named: "swap"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(revertSourceDestination), for: .touchUpInside)
        return button
    }()
    
    var labelFooterTableView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No match"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blue = UIColor(red:0.11, green:0.66, blue:0.94, alpha:1.0)
        
        self.view.backgroundColor = blue
        self.navigationItem.title = "Custom Itinerary"
        
        //Init SearchBar Source
        self.searchBarSource = UISearchBar()
        searchBarSource!.translatesAutoresizingMaskIntoConstraints = false
        searchBarSource!.placeholder = "Source"
        searchBarSource!.isTranslucent = false
        searchBarSource!.backgroundImage = UIImage()
        searchBarSource!.barTintColor = blue
        searchBarSource!.delegate = self
        
        //Init SearchBar destination
        self.searchBarDestination = UISearchBar()
        searchBarDestination!.translatesAutoresizingMaskIntoConstraints = false
        searchBarDestination!.placeholder = "Destination"
        searchBarDestination!.isTranslucent = false
        searchBarDestination!.barTintColor = blue
        searchBarDestination!.backgroundImage = UIImage()
        searchBarDestination!.delegate = self
        
        //Init Results Table
        self.tableResults = UITableView()
        self.tableResults!.translatesAutoresizingMaskIntoConstraints = false
        self.tableResults!.layer.borderWidth = 1.0
        self.tableResults!.layer.borderColor = UIColor.lightGray.cgColor
        
        self.tableResults?.register(cell.self, forCellReuseIdentifier: "secondcell")

        self.setViews()
        
        self.tableResults?.delegate = self
        self.tableResults?.dataSource = self
    }
    
    @objc func revertSourceDestination() {
        let pTemp: MKPlacemark? = placeSource
        let iTemp: MKMapItem? = itinerarySource
        let sTemp: String? = self.searchBarSource?.text
        placeSource = placeDestination
        itinerarySource = itineraryDestination
        searchBarSource?.text = searchBarDestination?.text
        placeDestination = pTemp
        itineraryDestination = iTemp
        searchBarDestination?.text = sTemp
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchText
        request.region = (self.mapView?.region)!
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableResults!.reloadData()
        }
        
        if searchBar == self.searchBarSource {
            activeSearchBar = 1
            itinerarySource = nil
            placeSource = nil
        } else if searchBar == self.searchBarDestination {
            activeSearchBar = 2
            itineraryDestination = nil
            placeDestination = nil
        } else {
            print("no match with: \(searchText)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell")! as! cell
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel!.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        if activeSearchBar == 1 {
            self.searchBarSource?.text = selectedItem.title
            placeSource = selectedItem
            itinerarySource = MKMapItem(placemark: MKPlacemark(coordinate:selectedItem.coordinate, addressDictionary: nil))
        } else if activeSearchBar == 2  {
            placeDestination = selectedItem
            self.searchBarDestination?.text = selectedItem.title
            itineraryDestination = MKMapItem(placemark: MKPlacemark(coordinate:selectedItem.coordinate, addressDictionary: nil))
        }
        matchingItems = []
        tableResults?.reloadData()
    }
    
    func parseAddress(_ selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    
    
    @objc func calculateItinerary() {
        if itineraryDestination != nil && itinerarySource != nil {
            if delegate != nil {
                delegate?.dropPinZoomIn(placemark: placeSource!, clear: true)
                delegate?.dropPinZoomIn(placemark: placeDestination!, clear: false)
                delegate!.drawItinerary(source: itinerarySource!, destination: itineraryDestination!)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setViews() {
        self.view.addSubview(searchBarSource!)
        self.searchBarSource!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.searchBarSource!.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -70).isActive = true
        self.searchBarSource!.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 70).isActive = true
        
        self.view.addSubview(searchBarDestination!)
        self.searchBarDestination!.topAnchor.constraint(equalTo: self.searchBarSource!.bottomAnchor).isActive = true
        self.searchBarDestination!.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -70).isActive = true
        self.searchBarDestination!.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 70).isActive = true
        
        
        self.view.addSubview(tableResults!)
        self.tableResults!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        self.tableResults!.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.tableResults!.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tableResults!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.view.addSubview(goButton)
        self.goButton.topAnchor.constraint(equalTo: self.searchBarDestination!.bottomAnchor, constant: 20).isActive = true
        self.goButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.goButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        
        //Footer TableResults
        let footerView = UIView()
        footerView.addSubview(labelFooterTableView)
        self.labelFooterTableView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        self.labelFooterTableView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: 50).isActive = true
        self.tableResults!.tableFooterView = footerView
        
        
        //Revert Button
        self.view.addSubview(self.revertButton)
        self.revertButton.centerYAnchor.constraint(equalTo: self.searchBarSource!.bottomAnchor).isActive = true
        self.revertButton.leftAnchor.constraint(equalTo: self.searchBarSource!.rightAnchor).isActive = true
        self.revertButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        self.revertButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    class cell: UITableViewCell {
        
        override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

}

extension UISearchBar {
    func setBackgrounColor(_ color: UIColor) {
        print("ici")
        for subView in self.subviews
        {
            for subView1 in subView.subviews {
            
//                if subView1 is UITextField
//                    print("ici")
//                {
//                    subView1.backgroundColor = color
//                }
            }
        }
    }
}
