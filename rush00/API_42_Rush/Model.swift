//
//  Model.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/13/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

func get_global(_ type: Int) -> String {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    if type == 0 {
        return appDelegate.token
    } else {
        return appDelegate.id_user
    }
}

struct Topics: CustomStringConvertible {
    let id: Int
    let name: String
    let user_id: String
    let date: String
    let text: String
    let kind: String = "normal"
    let language_id: Int = 1
    let content: String
    
    var description: String {
        return "\(id), \(name), \(date), \(text)\n"
    }
    
    func sendRequest(_ type: String) {
        var method: String
        var path: String
        let token: String = get_global(0)
        let userid: String = get_global(1)

        switch type {
        case "create":
            method = "POST"
            path = "https://api.intra.42.fr/v2/topics.json"
        case "mod":
            method = "PUT"
            path = "https://api.intra.42.fr/v2/topics/\(self.id).json"
        case "del":
            method = "DELETE"
            path = "https://api.intra.42.fr/v2/topics/\(self.id).json"
        default:
            return
        }
        if let url = URL(string: path) {
        var request = URLRequest(url: url)
        let json: [String: Any] = ["topic":["kind": "normal", "cursus_ids": ["1"], "language_id": "1", "messages_attributes": [["author_id": userid, "content": content]], "name": name, "tag_ids": ["578"]]]
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let string1 = String(data: jsonData!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
        print("JSON = \(string1)")
        request.httpBody = jsonData
        postTopic(request as URLRequest)
        } else {
            print("url == nil!")
        }
    }
    
}

func postTopic(_ request: URLRequest) {
    let task = URLSession.shared.dataTask(with: request) {
        (data, response, error) in
        if let err = error {
            print(err)
        }
        if let rep = response as? HTTPURLResponse {
            if rep.statusCode > 300 {
                let alertController = UIAlertController(title: "Error", message: "Cannot create topic", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                let rootController = UIApplication.shared.delegate?.window??.rootViewController
                rootController?.present(alertController, animated: true, completion: nil)
                return
            }
            else {
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data!) as! NSDictionary {
//                        print("post topic: \(json)")
                    }
                }
                catch (let err) {
                    print(err)
                }
            }
        }
    }
    task.resume()
}


struct Messages: CustomStringConvertible {
    let id: Int
    let name: String
    let user_id: String
    let date: String
    let text: String
    let topic_id: String
    let replies: [Messages]
    
    var description: String {
        return "\(id), \(name), \(date), \n\(text), \n\(replies)"
    }
    
    func sendRequest(_ type: String) {
        var method: String
        var path: String
        let token: String = get_global(0)
        let userid: String = get_global(1)
        
        switch type {
        case "create":
            method = "POST"
            path = "https://api.intra.42.fr/v2/topics/\(topic_id)/messages.json"
        case "mod":
            method = "PUT"
            path = "https://api.intra.42.fr/v2/messages/\(self.id).json"
        case "del":
            method = "DELETE"
            path = "https://api.intra.42.fr/v2/messages/\(self.id).json"
        default:
            return
        }
        if let url = URL(string: path) {
            var request = URLRequest(url: url)
            let json: [String: Any] = ["message":["author_id": userid, "content": text]]
            request.httpMethod = method
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            let string1 = String(data: jsonData!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
   //         print("JSON = \(string1)")
            request.httpBody = jsonData
            postTopic(request as URLRequest)
        } else {
            print("url == nil!")
        }
    }
 
}

