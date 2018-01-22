//
//  ViewController.swift
//  d09
//
//  Created by Paul DESPRES on 1/19/18.
//  Copyright © 2018 42. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Auth start")
        authenticate()
         // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authenticate () {
        let context = LAContext()
  
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: NSLocalizedString("Diary is private", comment: ""), reply: { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let innerPage: UINavigationController = mainStoryboard.instantiateViewController(withIdentifier:"Entry") as! UINavigationController
                        appDelegate.window?.rootViewController = innerPage
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alert(message: NSLocalizedString("Authentification failed!", comment: ""))
                        self.authenticate()
                    }
                }
                })
        }

    }
    
    
}

