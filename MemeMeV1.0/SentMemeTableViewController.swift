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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "selectEditController")

    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        detailViewController.receivedMeme = memes[indexPath.row]

        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SentMemeTableViewCell")!
        cell.imageView?.image = memes[indexPath.row].memedImage
        cell.textLabel?.text = "\(memes[indexPath.row].topText)...\(memes[indexPath.row].bottomText)"
   
        let longerSide  = ( self.view.frame.size.width > self.view.frame.size.height ) ? self.view.frame.size.width : self.view.frame.size.height

        
        tableView.rowHeight = longerSide / 4.0
        return cell
    }

}
