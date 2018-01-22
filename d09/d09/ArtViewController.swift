//
//  ArtViewController.swift
//  d09
//
//  Created by Paul DESPRES on 1/19/18.
//  Copyright © 2018 42. All rights reserved.
//

import UIKit
import pdespres2018

class ArtViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titre: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var content: UITextView!
    let pickerController = UIImagePickerController()
    var aM : ArticleManager?
    let langStr = NSLocale.preferredLanguages.first
    var art: Article?
    var reloadData: Bool = false
    
    @IBAction func btPictT(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func btPictC(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
            present(pickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btSave(_ sender: Any) {
        if titre.text == nil || titre.text == "" {
            alert(message: "Can't save without a title!")
            return
        }
        if art == nil {
            art = aM!.newArticle()
            art!.dateCreation = NSDate()
            art!.langue = langStr
        } else {
            art!.dateMod = NSDate()
        }
        art!.titre = titre.text
        art!.content = content.text
        if image.image != nil {
            art!.image = UIImagePNGRepresentation(image.image!)! as NSData
        }
        aM!.save()
        reloadData = true
        performSegue(withIdentifier: "segBack", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        
        if art != nil {
            titre.text = art!.titre
            content.text = art!.content
            if art!.image != nil {
                image.image = UIImage(data: art!.image! as Data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segBack" {
            if let vc = segue.destination as? TableViewController {
                     vc.reloadData = reloadData
                }
            }
    }

}
