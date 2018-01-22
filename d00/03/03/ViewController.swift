//
//  ViewController.swift
//  03
//
//  Created by Paul DESPRES on 1/8/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class Calcul {
    static let c = Calcul()
    
    var stk_calc: Double = 0
    
    init() {}
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let calc = Calcul()
    var stk_saisie: Double = 0
    var last_sign = ""
    
    @IBOutlet weak var lib_result: UILabel!
    
    @IBAction func b0(_ sender: Any) {
        calcr(pval: 0)
        print("0")
    }
    @IBAction func b1(_ sender: Any) {
        calcr(pval: 1)
        print("1")
    }
    @IBAction func b2(_ sender: Any) {
        calcr(pval: 2)
        print("2")
    }
    @IBAction func b3(_ sender: Any) {
        calcr(pval: 3)
        print("3")
    }
    @IBAction func b4(_ sender: Any) {
        calcr(pval: 4)
        print("4")
    }
    @IBAction func b5(_ sender: Any) {
        calcr(pval: 5)
        print("5")
    }
    @IBAction func b6(_ sender: Any) {
        calcr(pval: 6)
        print("6")
    }
    @IBAction func b7(_ sender: Any) {
        calcr(pval: 7)
        print("7")
    }
    @IBAction func b8(_ sender: Any) {
        calcr(pval: 8)
        print("8")
    }
    @IBAction func b9(_ sender: Any) {
        calcr(pval: 9)
        print("9")
    }
    @IBAction func bac(_ sender: Any) {
        calc.stk_calc = 0
        stk_saisie = 0
        last_sign = ""
        printr(pval: 0)
    }
    @IBAction func bneg(_ sender: Any) {
        stk_saisie = -stk_saisie
        printr(pval: stk_saisie)
        print("NEG")
    }
    @IBAction func bdiv(_ sender: Any) {
        resolve()
        last_sign = "/"
        print("/")
    }
    @IBAction func bmult(_ sender: Any) {
        resolve()
        last_sign = "*"
        print("*")
    }
    @IBAction func bmin(_ sender: Any) {
        resolve()
        last_sign = "-"
        print("-")
    }
    @IBAction func bplus(_ sender: Any) {
        resolve()
        last_sign = "+"
        print("+")
    }
    @IBAction func bequal(_ sender: Any) {
        resolve()
        last_sign = ""
        print("=")
    }
    
    func printr(pval: Double) {
        lib_result.text = String(format: pval == floor(pval) ? "%.0f": "%f", pval)
//        lib_result.text = "\(pval)"
    }
    func calcr(pval: Double) {
        stk_saisie = (stk_saisie * 10) + pval
        printr(pval: stk_saisie)
    }
    func op (n1: Double, n2: Double) -> Double {
        print("n1 " + String(n1) + ", n2 " + String(n2) + " op " + last_sign)
        if last_sign == "" {
            if n2 == 0 {
                return (n1)
            }
            else {
                return (n2)
            }
        }
        if last_sign == "+" {
            let r = n1.addingReportingOverflow(n2)
            if r.1 {
                calc.stk_calc = 0
                stk_saisie = 0
                last_sign = ""
                lib_result.text = "Overflow"
                return (0)
            } else {
                return r.0
            }
            //return (n1 + n2)
        }
        else if last_sign == "-" {
            let r = n1.subtractingReportingOverflow(n2)
            if r.1 {
                calc.stk_calc = 0
                stk_saisie = 0
                last_sign = ""
                lib_result.text = "Overflow"
                return (0)
            } else {
                return r.0
            }
            //return (n1 - n2)
        }
        else if last_sign == "*" {
            let r = n1.multipliedReportingOverflow(n2)
            if r.1 {
                calc.stk_calc = 0
                stk_saisie = 0
                last_sign = ""
                lib_result.text = "Overflow"
                return (0)
            } else {
                return r.0
            }
            //return (n1 * n2)
        }
        else {
            if n2 == 0 {
                calc.stk_calc = 0
                stk_saisie = 0
                last_sign = ""
                lib_result.text = "Not a number"
                return (0)
            }
            else {
                let r = n1.dividedReportingOverflow(n2)
                if r.1 {
                    calc.stk_calc = 0
                    stk_saisie = 0
                    last_sign = ""
                    lib_result.text = "Overflow"
                    return (0)
                } else {
                    return r.0
                }
                //return (n1 / n2)
            }
        }
    }
    func resolve() {
        calc.stk_calc = op(n1: calc.stk_calc, n2: stk_saisie)
        stk_saisie = 0
        if lib_result.text != "Not a number" && lib_result.text != "Overflow" {
            printr(pval: calc.stk_calc)
        }
    }
    
}

