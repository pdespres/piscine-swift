//
//  ViewController.swift
//  d02
//
//  Created by Paul DESPRES on 1/10/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        deathTab.rowHeight = UITableViewAutomaticDimension
        deathTab.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "seg_add" {
//            segue.destination
//        }
//    }
    
    @IBAction func unWindsegue(segue: UIStoryboardSegue) {
        deathTab.reloadData()
    }
    
    @IBOutlet weak var deathTab: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Note.death.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = deathTab.dequeueReusableCell(withIdentifier: "deathCell") as! DTableViewCell
        cell.death = Note.death[indexPath.row]
        return cell
    }
}

