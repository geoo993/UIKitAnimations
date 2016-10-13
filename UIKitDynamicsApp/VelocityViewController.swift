//
//  VelocityViewController.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 11/10/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import CoreMotion
import EasyAnimation


class VelocityViewController : UIViewController {
    
    var disposeBag = DisposeBag()
    let container = UIView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.randomColor()
        
        let obj = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        obj.backgroundColor = UIColor.redColor()
        self.view.addSubview(obj)
        
        
        let panGesture = UIPanGestureRecognizer()
        
        panGesture
            .rx_event
            .subscribeNext { gesture in
                
                let location = gesture.locationInView(self.view)
                let velocity = gesture.velocityInView(self.view)
                
                switch gesture.state {
                case .Began: 
                    
                    print("began", location, "velocity",velocity)
                case .Changed: 
                    
                    if velocity.x < 300 && velocity.x > -300 && velocity.y < 300 && velocity.y > -300 {
                    
                        obj.center = location
                    }else{
                        
                    }
                    print("changed", location,"velocity",velocity)
                case .Ended: 
                    
                    // 1
                    
                    //let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
                    //let slideMultiplier = magnitude / 200
                    //print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
                    
                    //// 2
                    //let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
                    //// 3
                    //var finalPoint = CGPoint(x:gesture.view!.center.x + (velocity.x * slideFactor),
                        //y:gesture.view!.center.y + (velocity.y * slideFactor))
                    //// 4
                    //finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
                    //finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
                    
                    //// 5
                    //UIView.animateWithDuration(Double(slideFactor * 2),
                        //delay: 0,
                        //// 6
                        //options: UIViewAnimationOptions.CurveEaseOut,
                        //animations: {gesture.view!.center = finalPoint },
                        //completion: nil)
                    
                    
                    print("ended", location,"velocity",velocity)
                default:
                    print("pan")
                }   
            }.addDisposableTo(disposeBag)
        self.view.addGestureRecognizer(panGesture)   
        
   
        
    }


}