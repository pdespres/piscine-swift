//
//  InnerPageViewController.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/13/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class InnerPageViewController: UIViewController, UIApplicationDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {

    var token: String!
    var user_id: String!
    var topics: [Topics] = []
    var topic_title: String!
    var topic_id: String!
    
    @IBAction func test(_ sender: Any) {
        topicsTable.delegate = self
        topicsTable.reloadData()
    }
    @IBOutlet weak var topicsTable: UITableView!
    
    @IBAction func bt_deco(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let innerPage: ViewController = mainStoryboard.instantiateViewController(withIdentifier: "First") as! ViewController
        appDelegate.window?.rootViewController = innerPage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.token = appDelegate.token
        self.user_id = appDelegate.id_user
        print("Token: \(self.token!) id: \(self.user_id)")
        APITopicsRequest(token: self.token)
        topicsTable.rowHeight = UITableViewAutomaticDimension
        topicsTable.estimatedRowHeight = 140
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (topics.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicsIdentifier", for: indexPath) as! TopicsTableViewCell
        cell.topicAuth.text = topics[indexPath.row].name
        cell.topicDate.text = topics[indexPath.row].date
        cell.topicName.text = topics[indexPath.row].text

        if topics[indexPath.row].user_id == user_id {
            cell.bt_edit.isEnabled = true
        } else {
            cell.bt_edit.isEnabled = false
        }
        return cell
    }
    
    func APITopicsRequest(token: String) {
        
        let url = "https://api.intra.42.fr/v2/topics?page=1&per_page=100&access_token=" + token
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
                            let topics_name: String! = forum["name"] as! String
                            let user = forum["author"]! as! NSDictionary
                            let name: String! = user["login"] as! String
                            let user_id: String! = String(describing: user["id"]!)
                            let date: String! =  forum["created_at"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            let date2 = dateFormatter.date(from: date!)
                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                            let newDate = dateFormatter.string(from: date2!)
                            self.topics.append(Topics(id: id, name: name, user_id: user_id, date: newDate, text: topics_name, content: ""))
                        }
                        //print(self.topics)
//                        print("hello")
                        DispatchQueue.main.async {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            self.user_id = appDelegate.id_user
                            self.topicsTable.reloadData()
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     @IBAction func unWindsegue(segue: UIStoryboardSegue) {
        print("unWindSegue OK")
        APITopicsRequest(token: self.token)
     }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TopicsTableViewCell
        self.topic_title = cell.topicName.text
        self.topic_id = String(topics[indexPath.row].id)
        performSegue(withIdentifier: "showmessSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(segue.identifier!)
        if segue.identifier! == "showmessSegue" {
            if let vc = segue.destination as? UITableViewController {
                vc.title = self.topic_title
                let dest = segue.destination as! MessTableViewController
                dest.token = self.token
                dest.id_topic = self.topic_id
            }
        } else if segue.identifier == "topicnewSegue" {
            if let vc = segue.destination as? TopicViewController {
                
            }
        } else if segue.identifier == "topiceditSegue" {
            if let vc = segue.destination as? TopicViewController {
                let button = sender as! UIButton
                if let cell = button.superview?.superview as? TopicsTableViewCell {
                    let indexPath = topicsTable.indexPath(for: cell)
                    vc.id_topic = String(topics[indexPath!.row].id)
                    vc.topic_title = topics[indexPath!.row].text
                }
            }
        }
    }

}
