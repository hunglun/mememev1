//
//  SentMemeCollectionViewController.swift
//  MemeMeV1.0
//
//  Created by hunglun on 12/30/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController : UICollectionViewController{

    @IBOutlet var flowLayout : UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    func selectEditController(){
        let editController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")
        presentViewController(editController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .Plain, target: self, action: "selectEditController")
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        detailViewController.receivedImage = memes[indexPath.row].memedImage
        
        presentViewController(detailViewController, animated: true, completion: nil)


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
