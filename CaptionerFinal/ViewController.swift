//
//  ViewController.swift
//  CaptionerFinal
//
//  Created by rkatakam on 12/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    //Variables and Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    let picker = UIImagePickerController()
    
    //Actions
    @IBAction func addButtonAction(sender: UIBarButtonItem) {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        picker.modalPresentationStyle = .Popover
        presentViewController(picker,
            animated: true,
            completion: nil)//4
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    @IBAction func editButtonAction(sender: UIBarButtonItem) {
        if imageView.image != nil {
            performSegueWithIdentifier("segue", sender: editButton)
        } else {
            let alert = UIAlertController(title: "Alert", message: "You must upload an image from your Camera Roll using the + button below", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    //Image picking method
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .ScaleAspectFit
        imageView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    //Cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true,
            completion: nil)
    }
    //Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! EditViewController
        dvc.image = imageView.image!
    }

}

