//
//  BlurUITextViewViewController.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 14/09/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import CoreMotion
import EasyAnimation


class BlurUITextViewViewController : UIViewController {
    
    var disposeBag = DisposeBag()
    let container = UIView()
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
//        self.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 0.0)
        
        let containerView = UIView(frame: view.frame)
//        containerView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 1.0)
        self.view.addSubview(containerView)
        
        
        
        let text = "We are more alike, my friends, than we are unalike. \nWe are more alike, my friends, than we are unalike. We are more alike, my friends, than we are unalike."
        
        
        let newtextFrame = view.frame.insetBy(dx: 40, dy: 40) // CGRect(x: 0, y: 0, width: 300, height:450)
        let textView = UITextView(frame: newtextFrame)
        textView.center = self.view.center
        
        textView.text = text
        textView.textAlignment = NSTextAlignment.Left
        textView.font = UIFont.systemFontOfSize(30.0);
        textView.editable = false
        //newText.roundCorners(UIRectCorner.AllCorners, radius: 5)
//        textView.backgroundColor = UIColor.clearColor()
        containerView.addSubview(textView)
        
        
        
        let tapToFocusWordEvents = textView.addTapToFocusWordFeature(disposeBag)
        tapToFocusWordEvents.subscribeNext {
            print($0)
            switch $0 {
            case let .didTapWord(word: word):
                print( word)
                tapToFocusWordEvents.onNext(.doZoomIn(duration: 1.0))
            case .zoomInComplete:
                print("zoom in Complete")
                tapToFocusWordEvents.onNext(.doZoomOut(duration: 1.0))
            case .zoomOutComplete:
                print("zoom out Complete")
                tapToFocusWordEvents.onNext(.doFinish)
            default: break
            }
        }.addDisposableTo(disposeBag)
        
        
        
        
 
//        print("self origin X", self.view.frame.origin.x, "self origin Y",self.view.frame.origin.y)
//        print("sel center X", self.view.center.x, "self center Y",self.view.center.y)
//        print("self bounds ", self.view.bounds)
//        print("self anchor point ", self.view.layer.anchorPoint)
//        
//        print("textview origin X", textView.frame.origin.x, "textview origin Y",textView.frame.origin.y)
//        print("textview center X", textView.center.x, "textview center Y",textView.center.y)
//        print("textview bounds ", textView.bounds)
//        print("textview anchor point ", textView.layer.anchorPoint)
//
//        
//        let frame = self.view.bounds
//        let clearColor = UIColor.clearColor().CGColor
//        let otherColor = UIColor.blackColor().CGColor
//        
//        let horizontalGradient = CAGradientLayer()
//        horizontalGradient.startPoint = CGPoint(x: 0, y: 0)
//        horizontalGradient.endPoint = CGPoint(x: 1, y: 0)
//        horizontalGradient.frame = frame//newText.superview?.bounds ?? CGRectNull
//        //only takes alpha
//        horizontalGradient.colors = [
//            clearColor, 
//            clearColor, 
//            otherColor, 
//            otherColor, 
//            clearColor, 
//            clearColor]
//        horizontalGradient.locations = [0.0, 0.15, 0.25, 0.75, 0.85, 1.0]
//        
//        let verticalGradient = CAGradientLayer()
//        verticalGradient.startPoint = CGPoint(x: 0, y: 0)
//        verticalGradient.endPoint = CGPoint(x: 0, y: 1)
//        verticalGradient.frame = frame //newText.superview?.bounds ?? CGRectNull
//        //only takes alpha
//        verticalGradient.colors = [
//            clearColor, 
//            clearColor, 
//            clearColor, 
//            clearColor, 
//            clearColor, 
//            clearColor]
//        verticalGradient.locations = [0.0, 0.15, 0.25, 0.75, 0.85, 1.0]
//        horizontalGradient.addSublayer(verticalGradient) 
//        //self.view.layer.addSublayer(horizontalGradient)
//        containerView.layer.mask = horizontalGradient
//        
//        
//        
//        
////        print("newtext anchor", newText.layer.anchorPoint, " hori layer anchor", horizontalGradient.anchorPoint)
////        
////        let layerOriginalTransform = horizontalGradient.transform
////        let layerOriginalAnchor = horizontalGradient.anchorPoint
//        
//        let originalAnchor = textView.layer.anchorPoint
//        let originalTransform = textView.layer.transform
//        let zoomScale : CGFloat = 2.0
//        
//        let longPressGesture = UILongPressGestureRecognizer()
//        longPressGesture.minimumPressDuration = 0.0
//        
//        longPressGesture
//            .rx_event
//            .subscribeNext { tap in
//                
//                let location = tap.locationInView(textView)
//                
//                switch tap.state {
//                case .Began: 
//                    
//                    let position = textView.closestPositionToPoint(location)
//                    guard let range = textView.tokenizer.rangeEnclosingPosition(position!, withGranularity: UITextGranularity.Word, inDirection: UITextDirection.min) 
//                        else {  return }
//                    let word = textView.textInRange(range)
//                    let wordRange = textView.textRangeToIntRange(range)
//                    guard let wordRect = textView.rectForRange(wordRange) else { return }
//                   
//                    let wordRectInSuperview = textView.convertRect(wordRect, toView: self.view)
//                    let borderSize = wordRect.height / 3
//                    let borderRectInSuperview = wordRectInSuperview.insetBy(dx: -borderSize, dy: -borderSize)
//                    print("wordRect", wordRect)
//                    print("wordRectInSuperview", wordRectInSuperview)
//                    print("borderRectInSuperview", borderRectInSuperview)
//
//                    
////                    let dot = CALayer()
////                    dot.cornerRadius = 4
////                    dot.frame = CGRect(x: wordRect.minX, y:wordRect.minY, width: 4, height: 4)
////                    dot.backgroundColor = UIColor.redColor().CGColor
////                    newText.layer.addSublayer(dot)
//                    
//                    wordHighlight.frame = wordRect
//                    let newAnchor = CGPoint(
//                        x: wordRect.midX / textView.frame.width, 
//                        y: wordRect.midY / textView.frame.height)
////                    let newLayerAnchor = CGPoint(
////                        x: wordRect.midX / horizontalGradient.frame.width, 
////                        y: wordRect.midY / horizontalGradient.frame.height)
////                    print("new anchor", newAnchor, "new layer anchor", newLayerAnchor)
////
////                    
//                    
//                   
//                    let horizontalLocations =
//                        [0.0, 
//                        borderRectInSuperview.minX, 
//                        wordRectInSuperview.minX,
//                        wordRectInSuperview.maxX, 
//                        borderRectInSuperview.maxX,
//                        self.view.frame.width]
//                    .map { $0 / self.view.frame.width }
//                    
//                    let verticalLocations =
//                        [0.0, 
//                        borderRectInSuperview.minY, 
//                            wordRectInSuperview.minY,
//                            wordRectInSuperview.maxY, 
//                            borderRectInSuperview.maxY,
//                            self.view.frame.height]
//                            .map { $0 / self.view.frame.height }
//                    
////                    print("top left", topLeft)
////                    print("top right", topRight)
////                    print("bottom left", bottomLeft)
////                    print("bottom right", bottomRight)
////                    print("horizontal anchor 1", horizontolAnchorPoint1)
////                    print("horizontal anchor 2", horizontolAnchorPoint2)
////                    print("vertical anchor 1", verticalAnchorPoint1)
////                    print("vertical anchor 2", verticalAnchorPoint2)
////                    
//                    
//                    UIView.animateWithDuration(1.0, delay: 0, options: [], animations: { 
//                    
//                        
////                        horizontalGradient.colors = [
////                            otherColor, 
////                            otherColor, 
////                            clearColor, 
////                            clearColor, 
////                            otherColor, 
////                            otherColor]
////                        horizontalGradient.locations = horizontalLocations
////
////                        verticalGradient.colors = [
////                            otherColor, 
////                            otherColor, 
////                            clearColor, 
////                            clearColor, 
////                            otherColor, 
////                            otherColor]
////                        verticalGradient.locations = verticalLocations
//
//                        
//                        
//                        }, completion: { _ in
//                            
//                                    
//                            UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: {
//                            
////                                    newText.layer.anchorPoint = newAnchor
////                                    horizontalGradient.anchorPoint = newLayerAnchor
//                                
////                                    let scaleTransform = originalTransform 
////                                    self.view.layer.transform = CATransform3DScale(scaleTransform, zoomScale, zoomScale, 1.0) 
////                                    //self.view.layer.transform = CATransform3DScale(horizontalGradient.transform, zoomScale, zoomScale, 1.0)
////            
//            
//                                }, completion: {_ in
//                                    
//                                    UIView.animateWithDuration(1.0, delay: 5.0, options: [], animations: {
//                                    
//                                        
////                                        newText.layer.anchorPoint = originalAnchor
////                                        horizontalGradient.anchorPoint = layerOriginalAnchor
//                                        
////                                        let scaleTransform = originalTransform 
////                                        self.view.layer.transform = scaleTransform
////                                        //self.view.layer.transform = layerOriginalTransform
//
//                                        
//                                        wordHighlight.frame = CGRect.zero
//                                        
//                                        
////                                        horizontalGradient.colors = [
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor]
////                                        //horizontalGradient.locations = [0,0,0,0,0,0]
////                                        verticalGradient.colors = [
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor, 
////                                            clearColor]
////                                        //verticalGradient.locations = [0,0,0,0,0,0]
//                                        
//                                    }, completion: nil)
//                            
//                            
//                            })
//                           
//                        })
//                    
//                    
//                    print("word", word, "wordrect", wordRect)
//                    print("began", location)
//                case .Changed: 
//                                        print("changed", location)
//                case .Ended: 
//                    print("ended", location)
//                default:
//                    print("tap ")
//                }   
//            }.addDisposableTo(disposeBag)
//        textView.addGestureRecognizer(longPressGesture)   

    }
    

    
    func imageWithView(view:UIView)->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    
    //let xPos = wordrect.origin.x + newText.frame.origin.x
    //let yPos = wordrect.origin.y + newText.frame.origin.y
    //wordHighlight.frame = CGRect(x: xPos, y: yPos, width: wordrect.width, height: wordrect.height)
    
    
    //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    //let blurEffectView = UIVisualEffectView(effect: blurEffect)
    //blurEffectView.frame = newText.bounds
    //blurEffectView.alpha = 0.0
    //blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
    //newText.addSubview(blurEffectView)
    
    
    //func animateScaleWord(word: String, range: UITextRange, textView: UITextView){
        
        //let wordRect = textView.firstRectForRange(range)
        
        //print("word", word, "wordRect", wordRect)
        
    
    
    
    //        let viewOb = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    //        viewOb.backgroundColor = UIColor.randomColor()
    //        self.view.addSubview(viewOb)
    
    
    
        //print("self origin X", self.view.frame.origin.x, "self origin Y",self.view.frame.origin.y)
        //print("sel center X", self.view.center.x, "self center Y",self.view.center.y)
        //print("self bounds ", self.view.bounds)
        
        //print("textview origin X", textView.frame.origin.x, "textview origin Y",textView.frame.origin.y)
        //print("textview center X", textView.center.x, "textview center Y",textView.center.y)
        
        //print("textview frame ", textView.frame)
        //print("textview bounds ", textView.bounds)
        
    //                    print("wordrect bounds", wordHighlight.bounds)
    //                    print("wordrect origin X", wordHighlight.frame.origin.x, "wordrect origin Y",wordHighlight.frame.origin.y)
    //                    print("wordrect center X", wordHighlight.center.x, "wordrect center Y",wordHighlight.center.y)
    //                    print("wordrect Min X", wordHighlight.frame.minX, "wordrect Min Y",wordHighlight.frame.minY)
    //                    print("wordrect Mid X", wordHighlight.frame.midX, "wordrect Mid Y",wordHighlight.frame.midY)
    //                    print("wordrect Max X", wordHighlight.frame.maxX, "wordrect Max Y",wordHighlight.frame.maxY)
    //                    print("wordrect anchor point ", wordHighlight.layer.anchorPoint)
    //                    
    
    
        
        //print("anchor point", self.textView?.layer.anchorPoint)
        
        //let newtextFrame = CGRect(x: wordRect.x, y: wordRect.y, w: wordRect.width + 20, h:wordRect.height)
        //let newText = UITextView(frame: newtextFrame)
        
        //let newtextCenterX = wordRect.midX + (self.view.center.x - textView.center.x)
        //let newtextCenterY = (textView.bounds.height + wordRect.maxY)
        //newText.centerX = newtextCenterX
        //newText.centerY = newtextCenterY
        
        //newText.text = word
        //newText.textAlignment = textView.textAlignment //NSTextAlignment.Center
        //newText.font = textView.font
        //newText.editable = false
        //newText.roundCorners(UIRectCorner.AllCorners, radius: 5)
        //newText.backgroundColor = UIColor.clearColor()
        //self.view.addSubview(newText)
        
        //let goToCenterX = self.view.center.x
        //let goToCentery = textView.center.y + self.view.center.y
        
        //UIView.animateAndChainWithDuration(1.0, delay: 0, options: [], animations: {
            
            //self.wordHighlight.alpha = 0.0
            //self.textBorder.alpha = 0.0
            //self.rippleTouchView.alpha = 0.0
            //self.textView?.alpha = 0.0
            
            //newText.centerX = goToCenterX
            //newText.centerY = goToCentery
            
            
            //}, completion: nil)
            //.animateWithDuration(1.0, animations: {
                
                
                //let newTextScaleAnim = newText.layer.transform
                //newText.layer.transform = CATransform3DScale(newTextScaleAnim, 2.0, 2.0, 1.0) 
                
            //})
            //.animateWithDuration(1.0, delay: 5.0, options: [], animations: { 
                
                //self.wordHighlight.alpha = 1.0
                //self.textBorder.alpha = 1.0
                //self.rippleTouchView.alpha = 1.0
                //self.textView?.alpha = 1.0
                
                
                //newText.centerX = newtextCenterX
                //newText.centerY = newtextCenterY
                //newText.layer.transform = CATransform3DScale(newText.layer.transform, 0.5, 0.5, 1.0)
                //newText.alpha = 0.0
                
                //print("finished animation")
                
                //}, completion: { success in })
        
        
        
    //}

    

}
