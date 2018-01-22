//
//  Tweet.swift
//  d04
//
//  Created by Paul DESPRES on 1/12/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import Foundation

struct Tweet : CustomStringConvertible {
    var description: String = ""
    
    let name : String
    let text : String
    let date : String
    
}

protocol APITwitterDelegate: class {
    func twit_process(t: [Tweet])
    func twit_error(e: NSError)
}

class APIController {
    weak var delegate : APITwitterDelegate?
    let token : String
    
    init(del: APITwitterDelegate?, tok: String) {
        self.delegate = del
        self.token = tok
    }
    
    func retrieve(search: String) {
        print(search)
        let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?" + search)
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in     
            if error != nil {
                DispatchQueue.main.async(execute: {
                    self.delegate?.twit_error(e: error! as NSError)
                })
                return
            }
            
            let d = data
            do {
                var twits: [Tweet] = []
                if let resp: NSDictionary = try JSONSerialization.jsonObject(with: d!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let statuses: [NSDictionary] = resp["statuses"] as? [NSDictionary] {
                        for status in statuses {
                            let name = (status["user"] as? NSDictionary)?["name"] as? String
                            let text = status["text"] as? String
                            let date = status["created_at"] as? String
                            if (name != nil) && (text != nil) && (date != nil) {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                if let date = dateFormatter.date(from: date!) {
                                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                    let newDate = dateFormatter.string(from: date)
                                    twits.append(Tweet(description: "\(name!), \(newDate)", name: name!, text: text!, date: newDate))
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.delegate?.twit_process(t: twits)
                        }
                    }
                }
                print(twits)
            } catch (let err){
                DispatchQueue.main.async(execute: {
                    self.delegate?.twit_error(e: err as NSError)
                })
                return
            }
            
        }
        task.resume()
    }
}


