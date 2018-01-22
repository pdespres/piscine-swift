//
//  ViewController.swift
//  API_42_Rush
//
//  Created by Quentin MOINAT on 1/13/18.
//  Copyright © 2018 Quentin MOINAT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let key = "96f2a961af427fff5a6a431e1c6b085316c107bfece732b313ff2076320c2f8b"
    
    @IBOutlet weak var image42: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else {
            return nil
        }
        print(url, param)
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    @IBAction func connexionButton(_ sender: UIButton) {
        let callbackUrl = "apprushurlequivalent%3A%2F%2Fhost%2Finner"
        let authURL = "https://api.intra.42.fr/oauth/authorize?client_id=\(key)&scope=public%20forum&response_type=code&redirect_uri=" + callbackUrl
        UIApplication.shared.openURL(NSURL(string: authURL)! as URL)
    }
}
