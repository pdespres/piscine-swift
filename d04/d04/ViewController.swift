//
//  ViewController.swift
//  d04
//
//  Created by Paul DESPRES on 1/12/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, APITwitterDelegate, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
    
    func twit_process(t: [Tweet]) {
        self.twits = t
        twitTableView.reloadData()
    }
    func twit_error(e: NSError) {
        print(e)
    }
    
    @IBOutlet weak var twitTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var twits: [Tweet] = []
    var token: String = ""
    let query:String = "&src=typd&lang=fr&count=100&result_type=recent"
    //    .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.text = "ecole 42"
        twitTableView.dataSource = self
        
        let CUSTOMER_KEY = "Zenv8MaOoARTA85MV9pFWuq3P"
        let CUSTOMER_SECRET = "yjGvhLpg9quCvmZfJq48cPQXlYzcWnWljglLBqrME9JEY19jqD"
        let BEARER = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString()

        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Basic " + BEARER, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;CHARSET=UTF-8", forHTTPHeaderField: "Content-type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
 
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let d = data
            do {
                if let dic : NSDictionary = try JSONSerialization.jsonObject(with: d!) as? NSDictionary {
                    for (key, value) in dic {
                        if key as! String == "access_token" {
                            self.token = value as! String
                        }
                    }
                    let controller = APIController(del: self, tok: self.token)
                    controller.retrieve(search: "q=" + "ecole 42".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + self.query)
                }
            } catch (let err){
                print(err)
                return
            }
        }
        task.resume()
        
        self.twitTableView.rowHeight = UITableViewAutomaticDimension
        self.twitTableView.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count \(twits.count)")
        return twits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = twitTableView.dequeueReusableCell(withIdentifier: "twitcell", for: indexPath) as! twitTableViewCell
        self.twitTableView.rowHeight = UITableViewAutomaticDimension
        self.twitTableView.estimatedRowHeight = 140
 
        cell.name.text = twits[indexPath.row].name
        cell.date.text = twits[indexPath.row].date
        cell.desc.text = twits[indexPath.row].text
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            twits = []
            let controller = APIController(del: self, tok: token)
            controller.retrieve(search: "q=" + searchBar.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + query)
        }
    }

}

