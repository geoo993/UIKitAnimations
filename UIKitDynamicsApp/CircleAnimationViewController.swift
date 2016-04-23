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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()
       
        let randX = self.view.frame.midX
        let randY = self.view.frame.midY
        let circleLength = CGFloat.random(100, max: 300)
        let lineW = 0.2 * circleLength
        
        //back ring
        var bgRingView = UIView() 
        bgRingView = createBackRing(bgRingView,frame: CGRectMake(0, 0, circleLength, circleLength),lineWidth: lineW, fillColor: UIColor.clearColor(), strokeColor: UIColor.randomColor())
        bgRingView.frame.origin = CGPoint(x: randX, y: randY)
        view.addSubview(bgRingView)
        
        //front ring
        let ringView = RingAround(frame: CGRectMake(0, 0, circleLength, circleLength))
        ringView.frame.origin = CGPoint(x: randX, y: randY)
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
            print(tick, durations[self.tickCount]) 
            
            let animationTime = NSTimeInterval(durations[self.tickCount])
            ringView.layerColor(UIColor.randomColor())
            ringView.animateRing(animationTime)
            
            self.tickCount += 1
            
        }.addDisposableTo(self.disposeBag)
        
        
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
                    //ringView.frame.origin = location
                    //bgRingView.frame.origin = location
                    
                    print("began", location)
                case .Changed: 
                    print("changed", location)
                case .Ended: 
                    print("ended", location)
                default:
                    print("tap ")
                }   
            }.addDisposableTo(disposeBag)
        self.view.addGestureRecognizer(longPressGesture)
        
        
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