//
//  GradientView.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 29/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    
    override func drawRect(rect: CGRect ) {
        
        // Default Colors
        let colorList : [CGColor] = [UIColor.randomColor().CGColor,UIColor.redColor().CGColor]
        
        // Must be set when the rect is drawn
        setGradient(rect.origin, gradientColors: colorList)
    }
    
    func setGradient(center: CGPoint,gradientColors: [CGColor]) {
        
        let context = UIGraphicsGetCurrentContext()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientLocations : [CGFloat] = [0, 0.3, 0.6, 1.0] //[0.0, 1.0] //[0, 0.25, 0.75, 1.0]
        
        let componentCount : Int = gradientLocations.count //4
        
        let colorOne = UIColor.randomColor();
        let colorOneComponents = CGColorGetComponents(colorOne.CGColor)
        let colorTwo = UIColor.randomColor();
        let colorTwoComponents = CGColorGetComponents(colorTwo.CGColor)
        let colorThree = UIColor.randomColor();
        let colorThreeComponents = CGColorGetComponents(colorThree.CGColor)
        let colorFour = UIColor.randomColor();
        let colorFourComponents = CGColorGetComponents(colorFour.CGColor)
        
        let colorComponents : [CGFloat] = [
                    0,   0,   0,   0,  //alpha 0
                    colorOneComponents[0], colorOneComponents[1], colorOneComponents[2], colorOneComponents[3], //color
                    colorTwoComponents[0], colorTwoComponents[1], colorTwoComponents[2], colorTwoComponents[3], //color
                   0,   0,   0,   0
                ]
        
        //let gradient = CGGradientCreateWithColors(colorSpace, gradientColors, gradientLocations)
        let gradient = CGGradientCreateWithColorComponents(colorSpace, colorComponents, gradientLocations, componentCount)
        
        
        // Draw Path
        let path = UIBezierPath(rect: CGRectMake(0, 0, frame.width, frame.height))
        CGContextSaveGState(context)
        path.addClip()
        
        //radius
        let gradientRadius = min(frame.width, frame.height)
        
        //center point
        let gradientCenter: CGPoint = CGPointMake(frame.width/2, frame.height/2)
        
        ////for linear gradient
        //let startPoint = CGPointMake(frame.width / 2, 0)//CGPointMake(0, self.bounds.height)
        //let endPoint = CGPointMake(frame.width / 2, frame.height)//CGPointMake(self.bounds.width, self.bounds.height)
        
        let gradientOptions: CGGradientDrawingOptions = [.DrawsAfterEndLocation] //CGGradientDrawingOptions()
        
        //CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, gradientOptions)
        CGContextDrawRadialGradient(context, gradient, gradientCenter, 100.0, gradientCenter, gradientRadius, gradientOptions)
        
        CGContextRestoreGState(context)
        
    }
    
    override func layoutSubviews() {
        
        // Ensure view has a transparent background color (not required)
        backgroundColor = UIColor.clearColor()
    }
    
}