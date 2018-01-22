//
//  AddViewController.swift
//  d02
//
//  Created by Paul DESPRES on 1/10/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inp_date.minimumDate = Date()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backSegue" {
            if let vc = segue.destination as? ViewController {
                if (inp_name.text != nil && inp_name.text != "") {
                    vc.title = "Updated Death notes"
                    let fdate = DateFormatter()
                    fdate.locale = Locale(identifier: "fr_FR")
                    fdate.dateFormat = "d MMMM yyyy HH:mm"
                    Note.death.append((inp_name.text!, inp_desc.text, fdate.string(from: inp_date.date)))
                }
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        performSegue(withIdentifier: "backSegue", sender: self)
    }
    
    @IBOutlet weak var inp_name: UITextField!
    @IBOutlet weak var inp_date: UIDatePicker!
    @IBOutlet weak var inp_desc: UITextView!

}
