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
    
    let disposeBag = DisposeBag()
    let container = UIView()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let text = "I note the obvious differences in the human family. \nSome of us are serious, some thrive on comedy. \nI've sailed upon the seven seas and stopped in every land, I've seen the wonders of the world not yet one common man. \nI know ten thousand women called Jane and Mary Jane, but I've not seen any two who really were the same. \nMirror twins are different although their features jibe, and lovers think quite different thoughts while lying side by side. \nI note the obvious differences between each sort and type, but we are more alike, my friends, than we are unalike. \nWe are more alike, my friends, than we are unalike. We are more alike, my friends, than we are unalike."
        
        
        let newtextFrame = CGRect(x: 0, y: 0, width: 300, height:450)
        let newText = UITextView(frame: newtextFrame)
        newText.center = self.view.center
        
        newText.text = text
        newText.textAlignment = NSTextAlignment.Left
        newText.font = UIFont(name:"Helvetica", size: 12.0)
        newText.font = UIFont.systemFontOfSize(16.0);
        newText.editable = false
        //newText.roundCorners(UIRectCorner.AllCorners, radius: 5)
        newText.backgroundColor = UIColor.clearColor()
        self.view.addSubview(newText)
        
        
        let wordHighlight = UIView(frame: CGRect.zero)
        wordHighlight.backgroundColor = UIColor.redColor()
        newText.addSubview(wordHighlight)
        
        wordHighlight.layer.zPosition = -1;
        
        
        let frame = newText.bounds
        let horizontalGradient = CAGradientLayer()
        horizontalGradient.startPoint = CGPoint(x: 0, y: 0)
        horizontalGradient.endPoint = CGPoint(x: 1, y: 0)
        horizontalGradient.frame = frame//newText.superview?.bounds ?? CGRectNull
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
        verticalGradient.frame = frame //newText.superview?.bounds ?? CGRectNull
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
        
        //newText.layer.addSublayer(horizontalGradient)
        newText.superview?.layer.mask = horizontalGradient
        
        newText.backgroundColor = UIColor.clearColor()
        
        
        
        
        let originalAnchor = newText.layer.anchorPoint
        let originalTransform = newText.layer.transform
        let zoomScale : CGFloat = 2.0
        
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 0.0
        
        longPressGesture
            .rx_event
            .subscribeNext { tap in
                
                let location = tap.locationInView(newText)
                
                switch tap.state {
                case .Began: 
                    
                    let position = newText.closestPositionToPoint(location)
                    guard let range = newText.tokenizer.rangeEnclosingPosition(position!, withGranularity: UITextGranularity.Word, inDirection: UITextDirection.min) 
                        else {  return }
                    let word = newText.textInRange(range)
                    let wordRange = newText.textRangeToIntRange(range)
                    guard let wordRect = self.rectForRange(wordRange, textView: newText) else { return }
                   
                    wordHighlight.frame = wordRect
                    
                    let newAnchor = CGPoint(
                    x: wordRect.midX / newText.frame.width, 
                    y: wordRect.midY / newText.frame.height)
                    
                    print("new anchor ", newAnchor)
                    
                    //let xPos = wordrect.origin.x + newText.frame.origin.x
                    //let yPos = wordrect.origin.y + newText.frame.origin.y
                    //wordHighlight.frame = CGRect(x: xPos, y: yPos, width: wordrect.width, height: wordrect.height)
                    
                   
                    //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
                    //let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    //blurEffectView.frame = newText.bounds
                    //blurEffectView.alpha = 0.0
                    //blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
                    //newText.addSubview(blurEffectView)
                    
                    
                    
                    UIView.animateWithDuration(1.0, delay: 0, options: [], animations: { 
                    
                        let newAnchor = CGPoint(
                            x: wordRect.midX / newText.frame.width, 
                            y: wordRect.midY / newText.frame.height)
                        
                        newText.layer.anchorPoint = newAnchor
                    
                        let scaleTransform = originalTransform 
                        self.view.layer.transform = CATransform3DScale(scaleTransform, zoomScale, zoomScale, 1.0) 
                        
                        //blurEffectView.alpha = 1.0
                        
                        }, completion: { _ in
                            
                                    
                            UIView.animateWithDuration(1.0, delay: 5.0, options: [], animations: {
                            
                            let scaleTransform = originalTransform 
                            self.view.layer.transform = scaleTransform
                            
                            wordHighlight.frame = CGRect.zero
                            
                            //blurEffectView.alpha = 0.0
                                
                                
                            newText.layer.anchorPoint = originalAnchor
                                
                            }, completion: nil)
                            
                            
                            
                        })
                    
                    
                    print("word", word, "wordrect", wordRect)
                    print("began", location)
                case .Changed: 
                                        print("changed", location)
                case .Ended: 
                    print("ended", location)
                default:
                    print("tap ")
                }   
            }.addDisposableTo(disposeBag)
        newText.addGestureRecognizer(longPressGesture)   

    }
    
    
    private let kWordHighlightHeightScale : CGFloat = 0.9
    func rectForRange(range: Range<Int>, textView: UITextView) -> CGRect? {
        if let
            start   = textView.positionFromPosition(textView.beginningOfDocument, offset: range.startIndex),
            end     = textView.positionFromPosition(textView.beginningOfDocument, offset: range.endIndex) {
            
            let textRange = textView.textRangeFromPosition(start, toPosition: end)
            var rect = textView.firstRectForRange(textRange!)
            let offset = textView.contentOffset
            let lineSpace :CGFloat = 0.0//StoryTweaks.assign(StoryTweaks.textViewVerticalLineSpace)
            let height = kWordHighlightHeightScale * (rect.height - lineSpace)
            let yOffset = (1.0 - kWordHighlightHeightScale) * (rect.height - lineSpace)
            rect.offsetInPlace(dx: 0, dy: -offset.y + yOffset)
            rect.size = CGSize(width: rect.width, height: height)
            return rect
        } else {
            return nil
        }
    }
    
    func imageWithView(view:UIView)->UIImage{
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    
    //func animateScaleWord(word: String, range: UITextRange, textView: UITextView){
        
        //let wordRect = textView.firstRectForRange(range)
        
        //print("word", word, "wordRect", wordRect)
        
        //print("self origin X", self.view.frame.origin.x, "self origin Y",self.view.frame.origin.y)
        //print("sel center X", self.view.center.x, "self center Y",self.view.center.y)
        //print("self bounds ", self.view.bounds)
        
        //print("textview origin X", textView.frame.origin.x, "textview origin Y",textView.frame.origin.y)
        //print("textview center X", textView.center.x, "textview center Y",textView.center.y)
        
        //print("textview frame ", textView.frame)
        //print("textview bounds ", textView.bounds)
        
        //print("wordrect bounds", wordRect)
        //print("wordrect origin X", wordRect.x, "wordrect origin Y",wordRect.y)
        //print("wordrect Max X", wordRect.maxX, "wordrect Max Y",wordRect.maxY)
        
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
