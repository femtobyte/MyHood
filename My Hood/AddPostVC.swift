//
//  AddPostVC.swift
//  My Hood
//
//  Created by C Sinclair on 12/4/15.
//  Copyright © 2015 femtobyte. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleFld: UITextField!
    @IBOutlet weak var descFld: UITextField!
    
    var imagePicker: UIImagePickerController!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        postImg.layer.cornerRadius = postImg.frame.size.width/2
        postImg.clipsToBounds = true
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        //setting textfield delegates for the keyboard dismiss funcs
        titleFld.delegate = self
        descFld.delegate = self
    }
    
    //  Called when 'return' key pressed. return NO to ignore.

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //  Handles dismissing keyboard if you touch outside the keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    @IBAction func addPicButtonPressed(sender: UIButton!) {
        //clears text on Add Img button
        sender.setTitle("", forState: .Normal)
        //presents image that was picked
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func makePostButtonPressed(sender: AnyObject) {
        if let title = titleFld.text, let desc = descFld.text, let img = postImg.image{
            let imgPath = DataService.instance.saveImageAndCreatePath(img)
            let post = Post(imgPath: imgPath, title: title, postDescription: desc)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
    }
}
