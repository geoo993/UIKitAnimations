//
//  RadialGradientLayer.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 29/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

class RadialGradientLayer: CALayer {
    
    
    override init(){
        
        super.init()
        
        needsDisplayOnBoundsChange = true
    }
    
    
    var origin: CGPoint?
    var center:CGPoint = CGPointMake(50,50)
    var locations: [CGFloat]?
    var radius:CGFloat = 20
    var colors:[CGColor] = [UIColor(red: 251/255, green: 237/255, blue: 33/255, alpha: 1.0).CGColor , UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).CGColor]
    
    //var colors: [UIColor]?
    
    init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
        
        self.center = center
        self.radius = radius
        self.colors = colors
        
        super.init()

        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init()
        
    }
    
    override func drawInContext(context: CGContext) {
        
        super.drawInContext(context)
       
        CGContextSaveGState(context)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        locations = [0.0, 1.0]
        
        let gradient = CGGradientCreateWithColors(colorSpace, colors, [0.0,1.0])
        
        let options: CGGradientDrawingOptions = [.DrawsAfterEndLocation]
        CGContextDrawRadialGradient(context, gradient!, center, 0.0, center, radius, options)
    }
    
    
    }
