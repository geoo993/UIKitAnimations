//
//  RingAround.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 23/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit

class RingAround: UIView {

    
    var circleColor = UIColor.randomColor()
    
    var timeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        let lineWidth : CGFloat = 0.2 * frame.size.width
        let pos = CGPointZero//CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = (frame.size.width / 2) 
        let startAngle = CGFloat(-M_PI_2) //0.0
        let endAngle = CGFloat(M_PI + M_PI_2) //CGFloat(M_PI * 2.0) 
        
        let circlePath = UIBezierPath(arcCenter:  pos, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        timeLayer = CAShapeLayer()
        timeLayer.path = circlePath.CGPath
        timeLayer.fillColor = UIColor.clearColor().CGColor
        timeLayer.strokeColor = circleColor.CGColor
        timeLayer.strokeEnd = 0.0
        timeLayer.lineWidth = lineWidth
        layer.addSublayer(timeLayer)
        
    }
  
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func layerColor(color:UIColor) {
        
        timeLayer.strokeColor = color.CGColor
    }
    func animateRing(duration: NSTimeInterval) {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration 
        
        animation.fromValue = 0.0
        animation.toValue = 1.0
        
        //animation.delegate = self
        animation.removedOnCompletion = false
        animation.additive = false
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        timeLayer.strokeEnd = 1.0
        timeLayer.addAnimation(animation, forKey: "animateRing")
    }
    
   
}
