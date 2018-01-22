//
//  ViewController.swift
//  d07
//
//  Created by Paul DESPRES on 1/17/18.
//  Copyright © 2018 42. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var field_question: UITextField!
    @IBOutlet weak var lab_answer: UILabel!
  
    let tokenRecast: String = "2d54ddc0cbde04adb28e15cf99f3daed"
    let tokenDark: String = "ab443594a6d4d17753bdce3a0b67e06a"
    var bot : RecastAIClient?
    var botAnswer : String = ""
    
    @IBAction func bt_ask(_ sender: Any) {
        if field_question.text != nil {
            lab_answer.text = ""
            self.bot = RecastAIClient(token : tokenRecast, language: "fr")
            bot?.textRequest(field_question.text!, successHandler: {
                (Response) -> Void in
                print(Response)
                if Response.intents?.count != 0 {
                    if Response.intent()?.slug == "get-weather" {
                        self.botAnswer = "Intent: Weather"
                        if let ret = Response.get(entity: "location") as NSDictionary? {
                            self.botAnswer = "\(self.botAnswer)\n\(ret.value(forKey: "formatted") as! String)"
                            if ret["lat"] != nil && ret["lng"] != nil {
                                self.askDarkSky(lat: ret.value(forKey: "lat") as! Double, lng: ret.value(forKey: "lng") as! Double)
                            }
                            
                        }
                    } else {
                        self.lab_answer.text = "Intent: \(String(describing: Response.intent()?.slug))"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.lab_answer.text = "Error: no intent"
                    }
                }
            }, failureHandle: {
                (Error) -> Void in
                print(Error)
                DispatchQueue.main.async {
                    self.lab_answer.text = "Error: error from Recast"
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field_question.delegate = self
        field_question.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bt_ask(textField)
        return true
    }
    
    func askDarkSky(lat: Double, lng: Double) {
        let client = DarkSkyClient(apiKey: tokenDark)
        client.language = .french
        client.units = .si
        client.getForecast(latitude: lat, longitude: lng) { result in
            switch result {
            case .success(let currentForecast, let requestMetadata):
                DispatchQueue.main.async {
                    self.lab_answer.text = "\(self.botAnswer)\n\n\(currentForecast.daily!.summary!)"
                    self.field_question.text = ""
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.lab_answer.text = "Error: error from Dark Sky"
                }
            }
        }
    }
//    Optional(ForecastIO.DataBlock(summary: Optional("Venté débutant cette nuit, se prolongeant jusqu’à demain matin, et pluie faible demain matin."), icon: Optional(ForecastIO.Icon.rain)
}

