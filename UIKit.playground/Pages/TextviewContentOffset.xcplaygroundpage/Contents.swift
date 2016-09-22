//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

let frame = CGRect(x: 0, y: 0, width: 300, height: 600) 
let textViewFrame = frame.insetBy(dx: 20, dy: 40)
let textView = UITextView(frame: textViewFrame)
textView.editable = false
textView.selectable = false
textView.font = UIFont.systemFontOfSize(40)
textView.text = "Hi George, this is some great work! Figuring out that UITextView needs to be selectable for rectToRange to work took some time. :-/"


textView.contentOffset = CGPoint(x: 0, y: 0)
textView.layer.borderWidth = 2
textView.layer.borderColor = UIColor.orangeColor().CGColor  


let vc = UIViewController()
let containerView = UIView(frame: textViewFrame)
containerView.addSubview(textView)
vc.view.frame = frame
vc.view.backgroundColor = UIColor.whiteColor()
vc.view.layer.borderWidth = 2
vc.view.layer.borderColor = UIColor.blueColor().CGColor 
//vc.view.clipsToBounds = true
vc.view.addSubview(containerView)

//textView.contentOffset
vc.view.frame
textView.frame
containerView.frame

vc.view.bounds
textView.bounds
containerView.bounds



XCPlaygroundPage.currentPage.liveView = vc