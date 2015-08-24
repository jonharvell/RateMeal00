//
//  ViewController.swift
//  RateMealScreen
//
//  Created by Harvell, Jon on 8/19/15.
//  Copyright (c) 2015 Harvell, Jon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var photoView: UIView!
    @IBOutlet weak var photoViewReally: UIView!
    @IBOutlet weak var imageButton: UIButton!
    
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var gravityBehavior : UIGravityBehavior!
    let tapRec = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        tapRec.addTarget(self.photoViewReally, action: "tappedButton")
        photoViewReally.addGestureRecognizer(tapRec)
        photoViewReally.userInteractionEnabled = true
        
        // Do any additional setup after loading the view, typically from a nib.
        
        animator = UIDynamicAnimator(referenceView: photoView)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func touchDown(sender: AnyObject) {
        
        
        spring(0.5) {
            self.imageButton.frame = CGRectMake(0, 0, 80, 80)
    }
    }
    
    @IBAction func handleGesture(sender: AnyObject) {
        let location = sender.locationInView(view)
        let myView = photoViewReally
        myView.center = location
        let boxLocation = sender.locationInView(myView)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(self.imageButton.bounds), boxLocation.y - CGRectGetMidY(self.imageButton.bounds))
            attachmentBehavior = UIAttachmentBehavior(item: self.imageButton, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
            
            
        }
            
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = location
    
    
            spring(0.5) {
                self.imageButton.frame = CGRectMake(boxLocation.x - CGRectGetMidX(self.imageButton.bounds), boxLocation.y - CGRectGetMidY(self.imageButton.bounds), 80, 80)
            }
    
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            animator.removeBehavior(attachmentBehavior)
            
            spring(0.5) {
                self.imageButton.frame = CGRectMake(boxLocation.x - CGRectGetMidX(self.imageButton.bounds), CGRectGetMidY(self.imageButton.bounds), 0, 0)
            }

        }
        
    }
}

