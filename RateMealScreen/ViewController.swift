//
//  ViewController.swift
//  RateMealScreen
//
//  Created by Harvell, Jon on 8/19/15.
//  Copyright (c) 2015 Harvell, Jon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var trackView: UIView!
    @IBOutlet var photoView: UIView!
    @IBOutlet weak var photoViewReally: UIView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var trackImage: UIImageView!
    @IBOutlet weak var bubbleImage: UIImageView!
    
    var animator : UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var attachmentBehaviorD : UIAttachmentBehavior!

    var gravityBehavior : UIGravityBehavior!
    let tapRec = UITapGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bubbleImage.alpha = 0
        trackImage.alpha = 0
        let scale = CGAffineTransformMakeScale(1.5, 1.5)
        let translate = CGAffineTransformMakeTranslation(0, 0)
        photoViewReally.transform = CGAffineTransformConcat(scale, translate)
        
        spring(0.5) {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.photoViewReally.transform = CGAffineTransformConcat(scale, translate)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        animator = UIDynamicAnimator(referenceView: photoView)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchDown(sender: AnyObject) {
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            imageButton.transform = CGAffineTransformConcat(scale, translate)
            
            spring(0.5) {
                let scale = CGAffineTransformMakeScale(0.5, 0.5)
                let translate = CGAffineTransformMakeTranslation(0, 0)
                self.imageButton.transform = CGAffineTransformConcat(scale, translate)
                self.trackImage.alpha = 1

            }
        }
    

//    @IBAction func touchDown(sender: AnyObject) {
//        let locationA = sender.locationInView(imageButton)
//        
//        spring(0.5) {
//            self.imageButton.frame = CGRectMake(0, 0, 80, 80)
//    }
//        
//        if sender.state == .Began {
//        let centerOffset = UIOffsetMake(locationA.x - CGRectGetMidX(self.imageButton.bounds), locationA.y - CGRectGetMidY(self.imageButton.bounds))
//        attachmentBehavior = UIAttachmentBehavior(item: self.imageButton, offsetFromCenter: centerOffset, attachedToAnchor: locationA)
//        attachmentBehavior.frequency = 0
//        }
//        
//        animator.addBehavior(attachmentBehavior)
//    }
    
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBAction func handleGesture(sender: AnyObject) {
        let location = sender.locationInView(view)
        let myView = photoViewReally
        myView.center = location
        let boxLocation = sender.locationInView(myView)
       

        
        if sender.state == UIGestureRecognizerState.Began {
            
             let translate = CGAffineTransformMakeTranslation(0, -80)
             let scale = CGAffineTransformMakeScale(1, 1)

            
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(self.imageButton.bounds), boxLocation.y - CGRectGetMidY(self.imageButton.bounds))
            attachmentBehavior = UIAttachmentBehavior(item: self.imageButton, offsetFromCenter: centerOffset, attachedToAnchor: location)
        
            spring(0.5) {
                self.bubbleImage.transform = CGAffineTransformConcat(scale, translate)
                self.bubbleImage.alpha = 1
            }
            
            attachmentBehavior.frequency = 0

            
            animator.addBehavior(attachmentBehavior)

            
            
            
        }
            
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = location
            
    
    
            spring(0.5) {
                self.imageButton.frame = CGRectMake(boxLocation.x - CGRectGetMidX(self.imageButton.bounds), boxLocation.y - CGRectGetMidY(self.imageButton.bounds), 80, 80)
                
                self.bubbleView.frame = CGRectMake(boxLocation.x, boxLocation.y - CGRectGetMidY(self.imageButton.bounds), 137, 87)
            
            
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

