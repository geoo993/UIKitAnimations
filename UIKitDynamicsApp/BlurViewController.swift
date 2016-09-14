//
//  BlurViewController.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 27/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import CoreMotion

class BlurViewController : UIViewController {
    
    let disposeBag = DisposeBag()
    let container = UIView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.randomColor()

        
        
        let imageName = "Hello"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        let frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.height)
        imageView.frame = frame
        self.view.addSubview(imageView)
       
        
        let myview = GradientView(frame: frame)
        
        
        //myview.setGradient(frame.origin,gradientColors: colors)
        //imageView.addSubview(myview)
        imageView.layer.mask = myview.layer
        
//        let screenCentre = CGPointMake(100, 100) 
//        let innerColour = UIColor.redColor().CGColor 
//        let outterColour = UIColor.greenColor().CGColor 
//        let radialGradientBackground = RadialGradientLayer(center: screenCentre, radius: CGFloat(250.0), colors: [innerColour, outterColour]) 
//        radialGradientBackground.frame = self.view!.bounds 
//        self.view!.layer.insertSublayer(radialGradientBackground, atIndex: 0) 
//        self.view!.setNeedsDisplay()
        
        
//        let topColor = UIColor(red: 15.0/255.0, green: 118.0/255.0, blue: 128.0/255.0, alpha: 1.0)
//        let bottomColor = UIColor(red: 84.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1.0)
//        
//        //Add the top and bottom colours to an array and setup the location of those two.
//        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
//        let gradientLocations: [CGFloat] = [0.0, 0.5]
//        
//        //Create a Gradient CA layer
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        
//        let color1 = UIColor.yellowColor().CGColor as CGColorRef
//                let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0).CGColor as CGColorRef
//                let color3 = UIColor.clearColor().CGColor as CGColorRef
//                let color4 = UIColor(white: 0.0, alpha: 0.7).CGColor as CGColorRef
//        gradientLayer.colors = [color1, color2, color3, color4]
//        
//        //gradientLayer.colors = gradientColors
//        gradientLayer.locations = gradientLocations
//                gradientLayer.cornerRadius = self.view.bounds.size.width/2.0;
//                gradientLayer.masksToBounds = true;
//        gradientLayer.frame = imageView.bounds
//        imageView.layer.insertSublayer(gradientLayer, atIndex: 0)
//       
     
    
        //addBlurArea(imageView,area: CGRect(x: 10, y: 100, width: 300, height: 300))
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 0.0
        
        longPressGesture
            .rx_event
            .subscribeNext { tap in
                
                let location = tap.locationInView(self.view)
                
                switch tap.state {
                case .Began: 
                    
                  
//                    let blurEff = UIBlurEffect(style: UIBlurEffectStyle.Light)
//                   
//                    let blurView = UIVisualEffectView(effect: blurEff)
//                    blurView.frame = imageView.bounds
//                    blurView.alpha = 0
//                    UIView.animateWithDuration(1.0) {
//                        blurView.alpha = 1.0
//    //                        blurView.effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//                    }
//                    imageView.addSubview(blurView)
                    
                    print("began", location)
                case .Changed: 
                    
                    //self.container.center = location
                    
                    
                    myview.center = location
                    
                    //let animationsViewController = AnimationsViewController()
                    //                    self.dismissViewControllerAnimated(true) {
                    //                        print("transition view controller dismissed")
                    //                    }
                    //self.presentViewController(animationsViewController, animated: true, completion: nil)
                    
                    print("changed", location)
                case .Ended: 
                    print("ended", location)
                default:
                    print("tap ")
                }   
            }.addDisposableTo(disposeBag)
        self.view.addGestureRecognizer(longPressGesture)          
                    
                
    }
    
    //func addBlurArea(parent: AnyObject, area: CGRect) {
        
        //let effect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        //let blurView = UIVisualEffectView(effect: effect)
        //blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        
        //container.frame = area
        //container.alpha = 0.8
        //container.layer.cornerRadius = container.frame.size.width/2
        //container.clipsToBounds = true
        //container.addSubview(blurView)
        
        //parent.insertSubview(container, atIndex: 1)
    //}
    
    //func drawCircle (area:CGRect)
    //{
    
        //let circlePath = UIBezierPath(arcCenter: area.origin, radius: area.width, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        //let shapeLayer = CAShapeLayer()
        //shapeLayer.path = circlePath.CGPath
        
        ////change the fill color
        //shapeLayer.fillColor = UIColor.clearColor().CGColor
        ////you can change the stroke color
        //shapeLayer.strokeColor = UIColor.randomColor().CGColor
        ////you can change the line width
        //shapeLayer.lineWidth = 4.0
        
        //self.view.layer.addSublayer(shapeLayer)
    //}
    
    
}