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
    var receivedMeme : Meme?
    
    func selectEditController(){
        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        editController.meme = receivedMeme

        presentViewController(editController, animated: true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "selectEditController")
        imageView.image = receivedMeme?.memedImage
    }
        
}
