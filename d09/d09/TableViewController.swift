//
//  TableViewController.swift
//  d09
//
//  Created by Paul DESPRES on 1/19/18.
//  Copyright © 2018 42. All rights reserved.
//

import UIKit
import pdespres2018

class TableViewController: UITableViewController {

//    let langStr = NSLocale.current.languageCode
    let langStr = NSLocale.preferredLanguages.first
    let aM = ArticleManager()
    var arts: [Article] = []
    var reloadData: Bool = false
    var artDel: Article? = nil
    
    @IBOutlet var tabArticle: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabArticle.delegate = self
        tabArticle.dataSource = self
        print("lang \(String(describing: langStr))")
        loadArts()
        tabArticle.rowHeight = UITableViewAutomaticDimension
        tabArticle.estimatedRowHeight = 140
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return arts.count
    }
    
    func loadArts() {
        arts = []
        arts = aM.getArticles(withLang: langStr!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellArt", for: indexPath) as! TableViewCell
        cell.titre.text = arts[indexPath.row].titre
        if arts[indexPath.row].image != nil {
            let i = UIImage(data: arts[indexPath.row].image! as Data)
            cell.imageArt.image = i
            cell.imageArt.isHidden = false
        } else {
            cell.imageArt.isHidden = true
        }
        cell.content.text = arts[indexPath.row].content
        let d = DateFormatter()
        d.locale = Locale(identifier: langStr!)
        d.setLocalizedDateFormatFromTemplate("MMM dd, YYYY 'at' HH:mm")
        cell.dateCreation.text = "Creation: \(d.string(from: arts[indexPath.row].dateCreation! as Date))"
        if arts[indexPath.row].dateMod != nil {
            cell.dateMod.text = "Modification: \(d.string(from: arts[indexPath.row].dateMod! as Date))"
            cell.dateMod.isHidden = false
        } else {
            cell.dateMod.isHidden = true
        }
        return cell
    }
    
    internal override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
//        self.topic_title = cell.topicName.text
//        self.topic_id = String(topics[indexPath.row].id)
        performSegue(withIdentifier: "segMod", sender: indexPath.row)
    }

      @IBAction func unWindsegue(segue: UIStoryboardSegue) {
        print("back seg Reload data? \(reloadData)")
        if reloadData {
            print("reload")
            loadArts()
            tabArticle.reloadData()
        }
     }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segMod" {
            if let vc = segue.destination as? ArtViewController {
                let row = sender as! Int
                vc.aM = aM
                print(arts[row].titre!)
                vc.art = arts[row]
            }
        } else if segue.identifier == "segCrea" {
            if let vc = segue.destination as? ArtViewController {
                vc.aM = aM
            }
        }
    }
    
    // Cell swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            artDel = arts[indexPath.row]
            confirmDelete(art: artDel!.titre!)
 
        }
    }
    
    func confirmDelete(art: String) {
        let alert = UIAlertController(title: "Delete article", message: "Are you sure you want to permanently delete \(art)?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteArt)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteArt)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    func handleDeleteArt(alertAction: UIAlertAction!) -> Void {
        aM.removeArticle(article: artDel!)
        loadArts()
        tabArticle.reloadData()
        artDel = nil
     }
    func cancelDeleteArt(alertAction: UIAlertAction!) {
        artDel = nil
    }
}
