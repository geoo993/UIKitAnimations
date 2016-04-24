//
//  CircleAnimationViewController.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 23/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import CoreMotion

class CircleAnimationViewController : UIViewController {
    
    
    let disposeBag = DisposeBag()
    
    var tickCount = 1
    
    func fadeInOutAnimation(shape:UIView,duration: NSTimeInterval)
    {
        let fadeAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 0.0
        fadeAnimation.toValue = 1
        fadeAnimation.duration = duration
        fadeAnimation.autoreverses = true
        fadeAnimation.repeatCount = FLT_MAX
        fadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // For convenience
        shape.layer.addAnimation(fadeAnimation, forKey: nil)
    }
    
    func colorAnimation(shape:UIView, startColor: UIColor, toColor: UIColor, duration: NSTimeInterval)
    {
        let colorAnimation: CABasicAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = startColor.CGColor 
        colorAnimation.toValue = toColor.CGColor 
        colorAnimation.duration = duration
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = FLT_MAX
       
        shape.layer.cornerRadius = 5.0 
        shape.layer.addAnimation(colorAnimation, forKey: "backgroundColor")
        
    }
        
    
    func borderColorAnimation(shape:UIView, startColor: UIColor, toColor: UIColor, duration: NSTimeInterval)
    {

        let color : CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        color.fromValue = startColor.CGColor
        color.toValue = toColor.CGColor
        shape.layer.backgroundColor = UIColor.randomColor().CGColor
        
        let Width : CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        Width.fromValue = 0
        Width.toValue = 6
        Width.duration = duration
        //shape.layer.borderWidth = 10
       
        let both:CAAnimationGroup = CAAnimationGroup()
        both.duration = duration
        both.repeatCount = FLT_MAX
        both.autoreverses = true
        both.animations = [color,Width]
        both.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        shape.layer.cornerRadius = 5.0 
        shape.layer.addAnimation(both, forKey: "color and Width")

    }
    func movingAnimation(shape:UIView,shape2:UIView,duration: NSTimeInterval)
    {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
      
        animation.fromValue = 0.0
        animation.toValue = 280
        animation.duration = duration
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.repeatCount = .infinity
        animation.autoreverses = true
       
        shape.layer.addAnimation(animation, forKey: "transform.translation.x")
        
        animation.beginTime = CACurrentMediaTime()+0.5
        
        shape2.layer.addAnimation(animation, forKey: "transform.translation.x")


    }
    func rotationAnimation(shape:UIView,duration: NSTimeInterval)
    {
        
        let fullRotation: CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation")
        fullRotation.fromValue =  0.0
        fullRotation.toValue = (360 * M_PI) / 180
        fullRotation.duration = duration
        fullRotation.repeatCount = .infinity
        fullRotation.removedOnCompletion = false
        fullRotation.speed = 5.0
        shape.layer.addAnimation(fullRotation, forKey: "transform.rotation")

    }
    
    func moveAnimation(shape:UIView,duration: NSTimeInterval) {
       
        let moveAnimation: CABasicAnimation = CABasicAnimation(keyPath:"transform.translation.x")
        moveAnimation.fromValue = 0.0
        moveAnimation.toValue = 200.0
        moveAnimation.duration = duration
        moveAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        moveAnimation.repeatCount = .infinity
        
        shape.layer.addAnimation(moveAnimation, forKey: "transform.translation.x")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()
        let rect = CGRect(x: -25, y: -25, width: 50, height: 50)
        
        var shapeMoveX = UIView()
        shapeMoveX = addLayer(shapeMoveX, rect: rect, roundedCorners: 5, color: UIColor.randomColor())
        shapeMoveX.frame.origin = CGPoint(x: 50, y: 50)
        view.addSubview(shapeMoveX)
        moveAnimation(shapeMoveX,duration: 5)
       
        var shapeScale1 = UIView()
        shapeScale1 = addLayer(shapeScale1, rect: rect, roundedCorners: 5, color: UIColor.randomColor())
        shapeScale1.frame.origin = CGPoint(x: 100, y: 150)
        view.addSubview(shapeScale1)
        UIView.animateWithDuration(1.0) {
            shapeScale1.transform = CGAffineTransformMakeScale(2, 2)
        }

        var shapeScale2 = UIView()
        shapeScale2 = addLayer(shapeScale2, rect: rect, roundedCorners: 5, color: UIColor.randomColor())
        shapeScale2.frame.origin = CGPoint(x: 300, y: 150)
        view.addSubview(shapeScale2)
        let option : UIViewAnimationOptions = [UIViewAnimationOptions.Repeat, .Autoreverse, .CurveEaseOut]
        UIView.animateWithDuration(0.5, delay: 0, options: option, animations: { 
            shapeScale2.transform = CGAffineTransformMakeScale(2, 2)
        }, completion: nil )
        
        var shapeRotate = UIView()
        shapeRotate = addLayer(shapeRotate, rect: rect, roundedCorners: 5, color: UIColor.randomColor())
        shapeRotate.frame.origin = CGPoint(x: 320, y: 625)
        view.addSubview(shapeRotate)
        rotationAnimation(shapeRotate,duration: 5)
        
        var shapeFade = UIView()
        shapeFade = addLayer(shapeFade, rect: rect, roundedCorners: 5, color: UIColor.randomColor())
        shapeFade.frame.origin = CGPoint(x: 220, y: 625)
        view.addSubview(shapeFade)
        fadeInOutAnimation(shapeFade, duration: 2.0)
        
        let shapeBorderColor = UIView(frame: rect)
        let borderColor = UIColor.randomColor()
        shapeBorderColor.frame.origin = CGPoint(x: 20, y: 600)
        view.addSubview(shapeBorderColor)
        borderColorAnimation(shapeBorderColor,startColor: borderColor,toColor: UIColor.randomColor(), duration: 1.0)
        
        let shapeColor = UIView(frame: rect)
        let colorr = UIColor.randomColor()
        shapeColor.frame.origin = CGPoint(x: 110, y: 600)
        view.addSubview(shapeColor)
        colorAnimation(shapeColor,startColor: colorr,toColor: UIColor.randomColor(), duration: 1.0)
           
        
        var mover = UIView()
        mover = addLayer(mover, rect: rect, roundedCorners: 5, color: UIColor.randomColor())
        mover.frame.origin = CGPoint(x: 50, y: 500)
        view.addSubview(mover)
        
        var mover2 = UIView()
        mover2 = addLayer(mover2, rect: rect, roundedCorners: 5, color: UIColor.randomColor())
        mover2.frame.origin = CGPoint(x: 50, y: 550)
        view.addSubview(mover2)
        movingAnimation(mover,shape2: mover2, duration: 5.0)
        
       
        
//        let option2 : UIViewAnimationOptions = [UIViewAnimationOptions.Repeat, .Autoreverse, .CurveEaseInOut]
//        UIView.animateWithDuration(0.2, delay: 0, options: option2, animations: { 
//            
//            mover.transform = CGAffineTransformMakeTranslation(100, 0) 
//            
//        }, completion: nil )
//        
        
        //let textRect = CGRect(x: 275, y: 640, width: 100, height: 20)
        //addTextLayer(textRect, word: "Hello George", fontSize: 12, roundedCorners: 5, alpha: 1)
        
        
        let xPos = self.view.frame.midX
        let yPos = self.view.frame.midY
        let circleLength = CGFloat.random(100, max: 180)
        let lineW = 0.2 * circleLength
                
        //back ring
        var bgRingView = UIView() 
        bgRingView = createBackRing(bgRingView,frame: CGRectMake(0, 0, circleLength, circleLength),lineWidth: lineW, fillColor: UIColor.clearColor(), strokeColor: UIColor.randomColor())
        bgRingView.frame.origin = CGPoint(x: xPos, y: yPos)
        view.addSubview(bgRingView)
        
        //front ring
        let ringView = RingAround(frame: CGRectMake(0, 0, circleLength, circleLength))
        ringView.frame.origin = CGPoint(x: xPos, y: yPos)
        view.addSubview(ringView)
   
        
        let durations = Array(0 ..< 50).map { idx -> Double in 
            let timeDelays = Double.roundToPlaces(Double.random(1.0, max: 5.0),places: 1)
            //print(timeDelays)
            return timeDelays
        }
        
        durations.toObservable()     
        .scan(0, accumulator: { acum, elem in
            acum + elem})
        .flatMap { delay -> Observable<Double>  in 
            
            return Observable<Int64>
                .timer(delay, scheduler: MainScheduler.instance)
                .map { _ in delay }
            
        }
        .subscribeNext { tick in 
            //print(tick, durations[self.tickCount]) 
            
            let animationTime = NSTimeInterval(durations[self.tickCount])
            ringView.layerColor(UIColor.randomColor())
            ringView.animateRing(animationTime)
            self.tickCount += 1
            
        }.addDisposableTo(self.disposeBag)
        
        
        
        
        var timer : CGFloat = 0
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 0.0
        
        longPressGesture
            .rx_event
            .subscribeNext { tap in
                
                let location = tap.locationInView(self.view)
                //let text = tap.view as? UIView
                
                switch tap.state {
                case .Began: 
                    
                    self.view.backgroundColor = UIColor.randomColor()
                    
                    //shapeMoveX.frame.origin = location
                    
                    //ringView.frame.origin = location
                    //bgRingView.frame.origin = location
                    
                    //print("began", location)
                case .Changed: 
                    
                    timer += 0.01
                    if timer > 1{
                        timer = 0
                    }
                    print(timer)
                    
                
                    //print("changed", location)
                case .Ended: 
                    print("ended", location)
                default:
                    print("tap ")
                }   
            }.addDisposableTo(disposeBag)
        self.view.addGestureRecognizer(longPressGesture)
        
        
    }
    
    func addLayer(shape:UIView,rect:CGRect,roundedCorners:CGFloat, color:UIColor) -> UIView
    {
        
        //print(rect.origin,self.label.frame.origin)
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = rect
        shadowLayer.cornerRadius = roundedCorners // 5
        shadowLayer.backgroundColor = color.CGColor
        shadowLayer.shadowColor = UIColor.blackColor().CGColor
        shadowLayer.borderWidth = 5
        shadowLayer.borderColor = UIColor.clearColor().CGColor
        shadowLayer.shadowOpacity = 0.6
        shadowLayer.shadowOffset = CGSizeMake(1, 1)
        shadowLayer.shadowRadius = 3
        
        shape.layer.addSublayer(shadowLayer)
        
        return shape
    }
    func addTextLayer(rect:CGRect, word:String,fontSize:CGFloat,roundedCorners:CGFloat,alpha:CGFloat) -> UILabel
    {
        
        let textLayer = CAShapeLayer()
        textLayer.frame = rect
        textLayer.cornerRadius = roundedCorners 
        textLayer.backgroundColor = UIColor.randomColor().CGColor
        textLayer.shadowColor = UIColor.blackColor().CGColor
        textLayer.shadowOpacity = 0.6
        textLayer.shadowOffset = CGSizeMake(1, 1)
        textLayer.shadowRadius = 3
        
        let label = UILabel()
        label.frame = rect
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center        
        label.text = word
        label.font = UIFont(name: "Helvetica", size: fontSize)
        label.alpha = alpha
        label.clipsToBounds = true
        
        self.view.layer.addSublayer(textLayer)
        self.view.addSubview(label)
         
        return label
    }
    
    func createBackRing(ui: UIView,frame:CGRect, lineWidth: CGFloat,fillColor: UIColor, strokeColor:UIColor) -> UIView
    {
        
        let pos = CGPointZero
        let radius = (frame.size.width / 2) 
        let startAngle = CGFloat(-M_PI_2) //0.0
        let endAngle = CGFloat(M_PI + M_PI_2) //CGFloat(M_PI * 2.0) 
        
        let circlePath = UIBezierPath(arcCenter: pos , radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let ring = CAShapeLayer()
        ring.path = circlePath.CGPath
        ring.fillColor = fillColor.CGColor
        ring.strokeColor = strokeColor.CGColor
        //ring.strokeEnd = 0.0
        ring.lineWidth = lineWidth
        ui.layer.addSublayer(ring)
        return ui
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}