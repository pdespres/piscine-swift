//
//  SecondViewController.swift
//  d05
//
//  Created by Paul DESPRES on 1/15/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spotCell", for: indexPath) as! SpotTableViewCell
        cell.Spot_name.text = spots[indexPath.row].title
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! SpotTableViewCell
        let Controller = self.tabBarController?.viewControllers?.first as! FirstViewController
        Controller.sendFromList = indexPath.row
        self.tabBarController!.selectedIndex = 0
    }
}

