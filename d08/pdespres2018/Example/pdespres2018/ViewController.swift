//
//  ViewController.swift
//  pdespres2018
//
//  Created by pdespres@student.42.fr on 01/18/2018.
//  Copyright (c) 2018 pdespres@student.42.fr. All rights reserved.
//

import UIKit
import pdespres2018

class ViewController: UIViewController {

    let articlemanager = ArticleManager()
    @IBAction func btTest(_ sender: Any) {
        print(articlemanager
            .getAllArticles())
    }
    
    override func viewDidLoad() {
        print("AM loaded")
        let art1 = articlemanager.newArticle()
        print("Art created")
        art1.titre = "Art 1"
        art1.content = "Art 1 du d08"
        art1.dateCreation = NSDate()
        art1.dateMod = NSDate()
        art1.langue = "fr"
        print("before save")
        articlemanager.save()
        print("after save")
        
        let art2 = articlemanager.newArticle()
        art2.titre = "Art 2"
        art2.content = "Art 2 from d08"
        art2.dateCreation = NSDate()
        art2.dateMod = NSDate()
        art2.langue = "en"
        articlemanager.save()
        
        print(articlemanager
        .getAllArticles())
        print(articlemanager
            .getArticles(withLang: "en"))
        print(articlemanager
            .getArticles(containString: "du d08"))
    }

}

