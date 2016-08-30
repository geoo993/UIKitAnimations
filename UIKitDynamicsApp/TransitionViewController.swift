//
//  TransitionViewController.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 24/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import CoreMotion


class TransitionViewController : UIViewController {
    
    let disposeBag = DisposeBag()
    
    let container = UIView()
    
    let redSquare = UIView()
    let blueSquare = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        
        self.view.backgroundColor = UIColor.randomColor()
        
        // set container frame and add to the screen
        self.container.frame = CGRect(x: 30, y: 150, width: 250, height: 250)
        self.view.addSubview(container)
        
        // set red square frame up
        // we want the blue square to have the same position as redSquare 
        // so lets just reuse blueSquare.frame
        self.redSquare.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        let redText = UILabel(frame: self.redSquare.frame)
        redText.text = "  RED"
        redText.font = redText.font?.fontWithSize(100)
        self.redSquare.addSubview(redText)
        
        self.blueSquare.frame = redSquare.frame
        let blueText = UILabel(frame: self.blueSquare.frame)
        blueText.text = " BLUE"
        blueText.font = redText.font?.fontWithSize(100)
        self.blueSquare.addSubview(blueText)
        
        
        // set background colors
        self.redSquare.backgroundColor = UIColor.redColor()
        self.blueSquare.backgroundColor = UIColor.blueColor()
        
        // for now just add the redSquare
        // we'll add blueSquare as part of the transition animation 
        self.container.addSubview(self.redSquare) 
        
        
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 0.0
        
        longPressGesture
            .rx_event
            .subscribeNext { tap in
                
                let location = tap.locationInView(self.view)
                //let text = tap.view! as UIView
                
                switch tap.state {
                case .Began: 
                    
                    
                    // create a 'tuple' (a pair or more of objects assigned to a single variable)
                    //let views = (frontView: self.redSquare, backView: self.blueSquare)
                    let views : (frontView: UIView, backView: UIView)
                    
                    // if redSquare has a superView (e.g it's in the container)
                    // set redSquare as front, and blueSquare as back
                    // otherwise flip the order
                    if((self.redSquare.superview) != nil){
                        views = (frontView: self.redSquare, backView: self.blueSquare)
                        print("red to blue")
                    }
                    else {
                        views = (frontView: self.blueSquare, backView: self.redSquare)
                        print("blue to red")
                    }
                    
                    
                    // set a transition style
                    let transitionOptions : [UIViewAnimationOptions] = [
                        .TransitionFlipFromLeft, 
                        .TransitionCrossDissolve, 
                        .TransitionCurlUp, 
                        .TransitionCurlDown,
                        .TransitionFlipFromTop, 
                        .TransitionFlipFromRight,
                        .TransitionFlipFromBottom]
                    
                    //pick transition
                    let transitionIndex = Int.random(0, max: transitionOptions.count-1)
                    
                    print(transitionIndex)
                    // with no animation block, and a completion block set to 'nil' this makes a single line of code  
                    UIView.transitionFromView(views.frontView, toView: views.backView, duration: 2, options: [transitionOptions[transitionIndex],.Autoreverse,.Repeat], completion: nil)
    
//                    UIView.transitionWithView(self.container, duration: 0.5, options: transitionOptions, animations: {
//                        
//                        // remove the front object...
//                        views.frontView.removeFromSuperview()
//                        
//                        // ... and add the other object
//                        self.container.addSubview(views.backView)
//                        
//                        }, completion: { finished in
//                        // any code entered here will be applied
//                        // .once the animation has completed
//                        self.redSquare.backgroundColor = UIColor.randomColor()
//                    })
                    
                    //print("began", location)
                case .Changed: 
                    
                    let animationsViewController = BlurViewController()
                    let blurr = 
                    self.dismissViewControllerAnimated(true) {
                        
                        
                    }
                   
                    //self.presentViewController(animationsViewController, animated: true, completion: nil)
                    
//                    self.transitionFromViewController( self, toViewController: animationsViewController, duration: 1.0, options: UIViewAnimationOptions.TransitionCurlUp, animations: { 
//                        
//                        }, completion: nil )
                
                    //print("changed", location)
                case .Ended: 
                    print("ended", location)
                default:
                    print("tap ")
                }   
            }.addDisposableTo(disposeBag)
        self.view.addGestureRecognizer(longPressGesture)
    }
  
    
    override func viewDidAppear(animated: Bool) {
        print("\(NSDate()) before Transition super.viewDidAppear(animated)")
        super.viewDidAppear(animated)
        
        print("\(NSDate()) after Transition super.viewDidAppear(animated)")
    }
    override func viewDidDisappear(animated: Bool) {
    
        print("\(NSDate()) before Transition super.viewDidDisappear(animated)")
        super.viewDidAppear(animated)
        
        print("\(NSDate()) after Transition super.viewDidDisappear(animated)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}