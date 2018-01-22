//
//  RepTableViewController.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/14/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class RepTableViewController: UITableViewController, UIApplicationDelegate, UITextFieldDelegate {

    var token: String!
    var id_mess: String!
    var rep_tab: [Messages]!
    
    @IBOutlet var repTab: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repTab.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (rep_tab.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repIdentifier", for: indexPath) as! RepTableViewCell
        cell.repAuth.text = rep_tab[indexPath.row].name
        cell.repDate.text = rep_tab[indexPath.row].date
        cell.repText.text = rep_tab[indexPath.row].text
        return cell
    }
    
    @IBAction func RepUnWindSegue(segue: UIStoryboardSegue) {
        print(segue.identifier!)
        self.repTab.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier! == "repeditSegue" {
            if let vc = segue.destination as? RepEditViewController {
                vc.title = "Edit Message"
                /*if let cell = button.superview?.superview as? TopicsTableViewCell {
                    let indexPath = topicsTable.indexPath(for: cell)
                    vc.repTextText = String(topics[indexPath!.row].id)
                    vc.topic_title = topics[indexPath!.row].text
                }*/
            }
        } else if segue.identifier! == "repnewSegue" {
            if let vc = segue.destination as? RepEditViewController {
                vc.title = "New Message"
            }
        }
    }
}
