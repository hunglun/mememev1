//
//  SentMemeTableViewController.swift
//  MemeMeV1.0
//
//  Created by hunglun on 12/30/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit

class SentMemeTableViewController : UITableViewController{

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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        detailViewController.imageView?.image = memes[indexPath.row].memedImage
        //TODO: troubleshoot imageView is nil
        if let _  = detailViewController.imageView {
            print("image view is not nil")
        }else {
            print("image view is nil")
          }
        presentViewController(detailViewController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeTableViewCell")!
        cell.imageView?.image = memes[indexPath.row].memedImage
        return cell
    }

}
