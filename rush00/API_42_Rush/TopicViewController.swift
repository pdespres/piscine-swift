//
//  TopicViewController.swift
//  API_42_Rush
//
//  Created by Paul DESPRES on 1/14/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {

    @IBOutlet weak var topicTitle: UITextField!
    @IBOutlet weak var topicContent: UITextView!

    @IBAction func bt_ok(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "TopicToTopics", sender: "OK")
    }
    
    @IBOutlet weak var bt_sup: UIBarButtonItem!
    
    @IBAction func bt_sup(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "TopicToTopics", sender: "del")
     }
    
    var id_topic: String = "0"
    var topic_title: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if id_topic != "0" {
            topicTitle.text = topic_title
        } else {
            bt_sup.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TopicToTopics" {
            if (topicTitle != nil && topicTitle.text != "") {
                print("in segue")
                let date = Date()
                let fdate = DateFormatter()
                fdate.locale = Locale(identifier: "fr_FR")
                fdate.dateFormat = "d MMMM yyyy HH:mm"
                let newtopic = Topics(id: Int(id_topic)!, name: self.topicTitle.text!, user_id: "", date: fdate.string(from: date), text: topicTitle.text!, content: topicContent.text)
                if id_topic == "0" {
                    newtopic.sendRequest("create")
                } else if sender as! String == "del" {
                    newtopic.sendRequest("del")
                } else {
                    newtopic.sendRequest("mod")
                }
            }
        }
    }

}
