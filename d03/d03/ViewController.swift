//
//  ViewController.swift
//  d03
//
//  Created by Paul DESPRES on 1/11/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

let qos = DispatchQoS.background.qosClass
let queue = DispatchQueue.global(qos: qos)
var networkCount: Int = 0

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let reuseIdentifier = "photocell"
    var selectedphoto: UIImage? = nil
    var images_cache = [String:UIImage]()
    var images = ["https://www.nasa.gov/sites/default/files/thumbnails/image/gcenter360.jpg", "https://www.nasa.gov/sites/default/files/thumbnails/image/image2browndwarf.jpg", "https://www.nasa.gov/sites/default/files/thumbnails/image/wildfire20171221.jpg", "https://www.nasa.gov/sites/default/files/thumbnails/image/broce_11_09_17_2.jpg"]
//    var images = ["http://www.setjrdstudryudryu.fr", "test de non-url", "https://www.nasa.gov/sites/default/files/thumbnails/image/wildfire20171221.jpg", "https://www.nasa.gov/sites/default/files/thumbnails/image/broce_11_09_17_2.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func alert (message: String) {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func load_image(link:String, cell:CollectionViewCell)
    {
        queue.async {
            DispatchQueue.main.async {
                cell.act_ind.startAnimating()
            }
            let imageUrlString = link
            if let imageUrl:URL = URL(string: imageUrlString) {
                if let imageData:NSData = NSData(contentsOf: imageUrl) {
                    let image = UIImage(data: imageData as Data)
                    //            self.images_cache[imageUrlString] = image
                    DispatchQueue.main.async {
                        cell.myimageview.image = image
                        cell.act_ind.stopAnimating()
                        networkCount -= 1
                        if networkCount == 0 {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alert(message: "Cannot access " + link)
                        cell.act_ind.stopAnimating()
                        networkCount -= 1
                        if networkCount == 0 {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        }
                    }
                }

            } else {
                DispatchQueue.main.async {
                    self.alert(message: "Bad URL " + link)
                    cell.act_ind.stopAnimating()
                    networkCount -= 1
                    if networkCount == 0 {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = UIColor.black
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
        imageView.center = self.view.center
        if (images_cache[images[indexPath.row]] != nil)
        {
            cell.myimageview.image = images_cache[images[indexPath.row]]
        }
        else
        {
            networkCount += 1
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            load_image(link: images[indexPath.row], cell: cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        selectedphoto = cell.myimageview.image!
        performSegue(withIdentifier: "seg_detail", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seg_detail" {
            if let vc = segue.destination as? DViewController {
                vc.image = selectedphoto
            }
//            performSegue(withIdentifier: "backSegue", sender: self)
        }

    }

}
