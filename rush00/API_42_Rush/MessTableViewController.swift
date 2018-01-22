//
//  MessTableViewController.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/13/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class MessTableViewController: UITableViewController, UIApplicationDelegate, UITextFieldDelegate {

    var token: String!
    var id_topic: String!
    var id_mess: String!
    var title_mess: String!
    var messages: [Messages] = []
    var rep_tab: [Messages]!
    
    @IBOutlet var messTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(self.token)
        //print(self.id_topic)
        APIMessagesRequest(token: token, id: id_topic)
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
        return (messages.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messIdentifier", for: indexPath) as! MessTableViewCell
        cell.messAuth.text = messages[indexPath.row].name
        cell.messDate.text = messages[indexPath.row].date
        cell.messText.text = messages[indexPath.row].text
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func APIMessagesRequest(token: String, id: String) {

        let url = "https://api.intra.42.fr/v2/topics/" + id + "/messages?page=1&per_page=100&access_token=" + token
        let request = NSMutableURLRequest(url: (URL(string : url) as! URL))
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            }
            else if let d = data {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: d, options: []) as! [NSDictionary] {
                        //print(json)
                        for forum in json {
                            let id: Int! = forum["id"] as! Int
                            let user = forum["author"]! as! NSDictionary
                            let name: String! = user["login"] as! String
                            let user_id: String! = String(describing: user["id"]!)
                            let date: String! =  forum["created_at"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            let date2 = dateFormatter.date(from: date!)
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                            let newDate = dateFormatter.string(from: date2!)
                            let text = forum["content"] as! String
                            let replies_tab = forum["replies"] as! NSArray
                            //print(replies)
                            var rep: [Messages] = []
                            for reply in replies_tab {
                                if let repl = reply as? NSDictionary {
                                    let id_rep: Int! = repl["id"] as! Int
                                    let user_rep = repl["author"]! as! NSDictionary
                                    let name_rep: String! = user_rep["login"] as! String
//                                    let user_id_rep: String! = String(describing: user_rep["id"]!)
                                    let date_rep: String! =  repl["created_at"] as! String
                                    let dateFormatter_rep = DateFormatter()
                                    dateFormatter_rep.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                                    let date2_rep = dateFormatter_rep.date(from: date_rep!)
                                    dateFormatter_rep.dateFormat = "dd/MM/yyyy HH:mm"
                                    let newDate_rep = dateFormatter_rep.string(from: date2_rep!)
                                    let text_rep = repl["content"] as! String
                                    rep.append(Messages(id: id_rep, name: name_rep, user_id: user_id, date: newDate_rep, text: text_rep, topic_id: self.id_topic, replies: []))
                                }
                            }
                            self.messages.append(Messages(id: id, name: name, user_id: "", date: newDate, text: text, topic_id: self.id_topic, replies: rep))
                        }
                        //print(self.messages)
                        DispatchQueue.main.async {
                            self.messTable.reloadData()
                        }
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    @IBAction func MessUnWindSegue(segue: UIStoryboardSegue) {
        print(segue.identifier!)
        self.messTable.reloadData();
    }
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MessTableViewCell
        self.title_mess = "Réponses à " + cell.messAuth.text!
        self.id_mess = String(messages[indexPath.row].id)
        self.rep_tab = messages[indexPath.row].replies
        performSegue(withIdentifier: "showrepSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier!)
        if segue.identifier! == "showrepSegue" {
            if let vc = segue.destination as? UITableViewController {
                vc.title = self.title_mess
                let dest = segue.destination as! RepTableViewController
                dest.token = self.token
                dest.id_mess = self.id_mess
                dest.rep_tab = self.rep_tab
            }
        } else if segue.identifier! == "messeditSegue" {
            if let vc = segue.destination as? MessEditViewController {
                vc.title = "Edit Message"
            }
        } else if segue.identifier! == "messnewSegue" {
            if let vc = segue.destination as? MessEditViewController {
                vc.title = "New Message"
            }
        }
    }

}
