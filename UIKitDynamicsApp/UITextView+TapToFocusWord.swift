//
//  UITextView+TapToFocusWord.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 15/09/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import UIKit
import RxSwift

extension UITextView : TapToFocusWordProviding {
    
    public func addTapToFocusWordFeature() -> PublishSubject<TapToFocusWordEvents> {
        var disposeBag = DisposeBag()
        
        let events = PublishSubject<TapToFocusWordEvents>()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.alpha = 1.0
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.insertSubview(blurEffectView, belowSubview: self )
        
        
        //let frame = self.view.bounds
        let clearColor = UIColor.clearColor().CGColor
        let otherColor = UIColor.blackColor().CGColor
        
        let horizontalGradient = CAGradientLayer()
        horizontalGradient.startPoint = CGPoint(x: 0, y: 0)
        horizontalGradient.endPoint = CGPoint(x: 1, y: 0)
        horizontalGradient.frame = frame//newText.superview?.bounds ?? CGRectNull
        //only takes alpha
        horizontalGradient.colors = [
            clearColor, 
            clearColor, 
            otherColor, 
            otherColor, 
            clearColor, 
            clearColor]
        horizontalGradient.locations = [0.0, 0.15, 0.25, 0.75, 0.85, 1.0]
        
        let verticalGradient = CAGradientLayer()
        verticalGradient.startPoint = CGPoint(x: 0, y: 0)
        verticalGradient.endPoint = CGPoint(x: 0, y: 1)
        verticalGradient.frame = frame //newText.superview?.bounds ?? CGRectNull
        //only takes alpha
        verticalGradient.colors = [
            clearColor, 
            clearColor, 
            clearColor, 
            clearColor, 
            clearColor, 
            clearColor]
        verticalGradient.locations = [0.0, 0.15, 0.25, 0.75, 0.85, 1.0]
        horizontalGradient.addSublayer(verticalGradient) 
        //self.view.layer.addSublayer(horizontalGradient)
        blurEffectView.layer.mask = horizontalGradient
        
       
        
        let longPressGesture = UILongPressGestureRecognizer()
        longPressGesture.minimumPressDuration = 0.0
        
        longPressGesture
            .rx_event
            .subscribeNext { tap in
                
                let location = tap.locationInView(self)
                
                switch tap.state {
                case .Began: 
                    
                    let position = self.closestPositionToPoint(location)
                    guard let range = self.tokenizer.rangeEnclosingPosition(position!, withGranularity: UITextGranularity.Word, inDirection: UITextDirection.min) 
                        else {  return }
                    let word = self.textInRange(range)
                    let wordRange = self.textRangeToIntRange(range)
                    guard let wordRect = self.rectForRange(wordRange) else { return }
                    
                   
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
        self.addGestureRecognizer(longPressGesture)   
        
        
        return events
        
    }
}
