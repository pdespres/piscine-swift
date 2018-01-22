//
//  ViewController.swift
//  01
//
//  Created by Paul DESPRES on 1/8/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lib: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func bt_hello(_ sender: Any) {
        lib.text = "Hello World!"
    }
    
}

