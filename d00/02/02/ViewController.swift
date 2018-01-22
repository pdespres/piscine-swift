//
//  ViewController.swift
//  02
//
//  Created by Paul DESPRES on 1/8/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var lib_result: UILabel!
    
    @IBAction func b0(_ sender: Any) {
        lib_result.text = "0"
        print("0")
    }
    @IBAction func b1(_ sender: Any) {
        lib_result.text = "1"
        print("1")
    }
    @IBAction func b2(_ sender: Any) {
        lib_result.text = "2"
        print("2")
    }
    @IBAction func b3(_ sender: Any) {
        lib_result.text = "3"
        print("3")
    }
    @IBAction func b4(_ sender: Any) {
        lib_result.text = "4"
        print("4")
    }
    @IBAction func b5(_ sender: Any) {
        lib_result.text = "5"
        print("5")
    }
    @IBAction func b6(_ sender: Any) {
        lib_result.text = "6"
        print("6")
    }
    @IBAction func b7(_ sender: Any) {
        lib_result.text = "7"
        print("7")
    }
    @IBAction func b8(_ sender: Any) {
        lib_result.text = "8"
        print("8")
    }
    @IBAction func b9(_ sender: Any) {
        lib_result.text = "9"
        print("9")
    }
    @IBAction func bac(_ sender: Any) {
        print("AC")
    }
    @IBAction func bneg(_ sender: Any) {
        print("NEG")
    }
    @IBAction func bdiv(_ sender: Any) {
        print("/")
    }
    @IBAction func bmult(_ sender: Any) {
        print("*")
    }
    @IBAction func bmin(_ sender: Any) {
        print("-")
    }
    @IBAction func bplus(_ sender: Any) {
        print("+")
    }
    @IBAction func bequal(_ sender: Any) {
        print("=")
    }
}

