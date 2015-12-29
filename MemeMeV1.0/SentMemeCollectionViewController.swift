//
//  SentMemeCollectionViewController.swift
//  MemeMeV1.0
//
//  Created by hunglun on 12/30/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController : UICollectionViewController{
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    func selectEditController(){
        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")
        presentViewController(editController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "selectEditController")
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }
    override func collectionView(tableView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(tableView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView?.dequeueReusableCellWithReuseIdentifier("SentMemeCollectionViewCell", forIndexPath: indexPath) as! SentMemeCollectionViewCell

         cell.imageView?.image = memes[indexPath.row].memedImage

        return cell
    }
    
}
