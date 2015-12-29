//
//  DetailViewController.swift
//  MemeMeV1.0
//
//  Created by hunglun on 12/30/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {

    @IBOutlet var imageView: UIImageView!
    var receivedImage : UIImage?
    
    @IBAction func ok() {
        let tabController = self.storyboard!.instantiateViewControllerWithIdentifier("TabController")
        presentViewController(tabController, animated: true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        imageView.image = receivedImage
    }
        
}
