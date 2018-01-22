//
//  RepEditViewController.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/14/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class RepEditViewController: UIViewController {

    @IBOutlet weak var repTextText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func repBackButton(_ sender: UIBarButtonItem) {
        if let text = repTextText.text {
            if text != "" {
                performSegue(withIdentifier: "RepUnWindSegue", sender: "Foo")
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
