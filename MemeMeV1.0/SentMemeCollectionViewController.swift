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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "selectEditController")

        let space: CGFloat = 3.0

        let shorterSide = ( self.view.frame.size.width < self.view.frame.size.height ) ? self.view.frame.size.width : self.view.frame.size.height
        let longerSide  = ( self.view.frame.size.width > self.view.frame.size.height ) ? self.view.frame.size.width : self.view.frame.size.height

        let width = (shorterSide - (2 * space)) / 3.0
        let height = (longerSide - (2 * space)) / 4.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(width, height)
    
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        detailViewController.receivedMeme = memes[indexPath.row]
        
        self.navigationController!.pushViewController(detailViewController, animated: true)


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
