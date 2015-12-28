//
//  ViewController.swift
//  MemeMeV1.0
//
//  Created by hunglun on 12/27/15.
//  Copyright © 2015 hunglun. All rights reserved.
//

import UIKit


struct Meme {
    let topText : String
    let bottomText : String
    let image : UIImage
    let memedImage : UIImage
}

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var shareButton: UIBarButtonItem!

    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var imageView: UIImageView!
    var userEnteredTextTop : String?
    var userEnteredTextBottom : String?
    
    let memeTextAttributes = [
        // black outline
        NSStrokeColorAttributeName : UIColor(white: 0, alpha: 1),
        NSForegroundColorAttributeName : UIColor(white: 1, alpha: 1),         // white fill
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3
    ]
    
    @IBOutlet var navbar: UINavigationBar!
    @IBOutlet var toolbar: UIToolbar!
    func generate_memedImage () -> UIImage {

        toolbar.hidden = true
        navbar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        

        toolbar.hidden = false
        navbar.hidden = false
        return memedImage
    
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        imageView.image = nil
        topTextField.text = ""
        bottomTextField.text = ""
        shareButton.enabled = false

    }
    @IBAction func share(sender: AnyObject) {
 
        
    /* generate a memed image
    define an instance of the ActivityViewController
    pass the ActivityViewController a memedImage as an activity item
    present the ActivityViewController
    */
        let meme = save()
        let activityController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)

    }
    func save() -> Meme{
        //Create the meme
        let meme = Meme( topText: topTextField.text!, bottomText : bottomTextField.text!, image:
            imageView.image!, memedImage : generate_memedImage())
        return meme
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.defaultTextAttributes = memeTextAttributes
   
        bottomTextField.textAlignment = .Center
        topTextField.textAlignment = .Center
        
        bottomTextField.delegate = self
        topTextField.delegate = self
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
 
        if let _ = imageView.image {
            shareButton.enabled = true
        }else {
            shareButton.enabled = false
        }
        print("share button: \(shareButton.enabled)")
        
        subscribeToKeyboardNotifications()
      }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == topTextField && textField.text == "TOP"{
            textField.text = ""
        }
        if textField == bottomTextField && textField.text == "BOTTOM"{
            textField.text = ""
        }
        

    }
    func textFieldDidEndEditing(textField: UITextField) {
        textField.sizeToFit()
        if textField == topTextField {
            userEnteredTextTop = textField.text
        }
        if textField == bottomTextField {
            userEnteredTextBottom = textField.text
        }
        print ("top \(userEnteredTextTop) bottom \(userEnteredTextBottom)")

    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // dismiss keyboard
        textField.resignFirstResponder()

        return true
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
         imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
   
        bottomTextField.text = "BOTTOM"
        topTextField.text = "TOP"
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func getKeyboardHeight(notification : NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    
    }
    
    func keyboardWillHide(notification : NSNotification){
        if bottomTextField.isFirstResponder(){
            
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    
    func keyboardWillShow(notification : NSNotification){
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    
    }

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }

    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }

}

