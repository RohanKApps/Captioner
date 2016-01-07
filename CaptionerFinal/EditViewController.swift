//
//  EditViewController.swift
//  CaptionerFinal
//
//  Created by rkatakam on 12/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    //Global Variables and Outlets
    var image : UIImage = UIImage()
    @IBOutlet weak var previewImageView: UIImageView!
    let tap = UITapGestureRecognizer()
    var location : CGPoint = CGPoint()
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    //Methods and Actions
    func alert(){
        let alert = UIAlertController(title: "Success", message: "You have successfully saved your image to your Camera Roll!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
        
    }
    
    @IBAction func saveImage(sender: UIBarButtonItem) {
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == true, animated: true) //or animated: false
        
        let myTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("screenShotMethod"), userInfo: nil, repeats: false)
        
        
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: true) //or animated: false
        
        let myTimer2 : NSTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("alert"), userInfo: nil, repeats: false)
    }
    
    @IBAction func keyboardDownAction(sender: UIButton) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImageView.userInteractionEnabled = true
        
        tap.addTarget(self, action: "imageTapped")
        
        previewImageView.addGestureRecognizer(tap)
        
        previewImageView.image = image
    }
    
    //Image Tapped Function
    var iterate = 0
    func imageTapped(){
        location = tap.locationInView(view)
        let txtField: UITextField = UITextField(frame: CGRect(x: 0, y: location.y, width: screenSize.width, height: 30.00));
        print(location)
        txtField.borderStyle = UITextBorderStyle.Line
        txtField.alpha = 0.5
        txtField.textAlignment = NSTextAlignment.Center
        txtField.text = ""
        txtField.backgroundColor = UIColor.greenColor()
        self.view.addSubview(txtField)
    }
}
