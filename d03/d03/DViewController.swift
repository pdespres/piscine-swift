//
//  DViewController.swift
//  d03
//
//  Created by Paul DESPRES on 1/11/18.
//  Copyright © 2018 Paul Despres. All rights reserved.
//

import UIKit

class DViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView: UIImageView?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(image: image)
        scrollview.addSubview(imageView!)
        scrollview.contentSize = (imageView?.frame.size)!
        scrollview.maximumZoomScale = 100
 //       scrollview.minimumZoomScale = 0.3
        scrollview.minimumZoomScale = min(scrollview.bounds.size.width / (imageView?.image?.size.width)!, scrollview.bounds.size.height / (imageView?.image?.size.height)!)
        
//        if (self.scrollView.zoomScale < self.scrollView.minimumZoomScale)
//        self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    @IBOutlet weak var scrollview: UIScrollView!
}
