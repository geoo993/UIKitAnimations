//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
let newText = UIView(frame: frame)
newText.backgroundColor = UIColor.blueColor()

let horizontalGradient = CAGradientLayer()
horizontalGradient.frame = frame 
horizontalGradient.startPoint = CGPoint(x: 0, y: 0)
horizontalGradient.endPoint = CGPoint(x: 1, y: 0)
//horizontalGradient.frame = newText.superview?.bounds ?? CGRectNull
//only takes alpha
horizontalGradient.colors = [
    UIColor.blackColor().CGColor, 
    UIColor.blackColor().CGColor, 
    UIColor.clearColor().CGColor, 
    UIColor.clearColor().CGColor, 
    UIColor.blackColor().CGColor, 
    UIColor.blackColor().CGColor]
horizontalGradient.locations = [0.0, 0.15, 0.25, 0.75, 0.85, 1.0]




let verticalGradient = CAGradientLayer()
verticalGradient.startPoint = CGPoint(x: 0, y: 0)
verticalGradient.endPoint = CGPoint(x: 0, y: 1)
verticalGradient.frame = frame
//only takes alpha
verticalGradient.colors = [
UIColor.blackColor().CGColor, 
UIColor.blackColor().CGColor, 
UIColor.clearColor().CGColor, 
UIColor.clearColor().CGColor, 
UIColor.blackColor().CGColor, 
UIColor.blackColor().CGColor]
verticalGradient.locations = [0.0, 0.15, 0.25, 0.75, 0.85, 1.0]

horizontalGradient.addSublayer(verticalGradient) 

newText.layer.addSublayer(horizontalGradient)
//newText.layer.mask = horizontalGradient

XCPlaygroundPage.currentPage.liveView = newText


print("Finished")

//: [Next](@next)
