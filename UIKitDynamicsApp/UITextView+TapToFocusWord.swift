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
    
    public func addTapToFocusWordFeature(disposeBag: DisposeBag, config: TapToFocusWordConfig? = nil) -> PublishSubject<TapToFocusWordEvents> {
        
        let config = config ?? TapToFocusWordConfig.defaultConfig
        
        let zoom = config.zoomDuration
        let events = PublishSubject<TapToFocusWordEvents>()
 
        guard let blurOverlay = (self as UIView).blur(blurRadius: 2.0)
            else {
                events.onNext(.didFail)
                events.onCompleted()
                return events
            }
        
     
        let clearColor = UIColor.clearColor().CGColor
        let opaqueColor = UIColor.blackColor().CGColor
        
        let horizontalGradient = CAGradientLayer()
        horizontalGradient.startPoint = CGPoint(x: 0, y: 0)
        horizontalGradient.endPoint = CGPoint(x: 1, y: 0)
        horizontalGradient.frame = self.bounds
        //only takes alpha
        horizontalGradient.colors = [
            clearColor,
            clearColor,
            clearColor,
            clearColor]
        horizontalGradient.locations = 
            [0.0,  
            self.frame.minX,
            self.frame.maxX, 
            self.frame.width]
            .map { $0 / self.frame.width }
        
        let verticalGradient = CAGradientLayer()
        verticalGradient.startPoint = CGPoint(x: 0, y: 0)
        verticalGradient.endPoint = CGPoint(x: 0, y: 1)
        verticalGradient.frame = self.bounds 
        //only takes alpha
        verticalGradient.colors = [
            clearColor,
            clearColor,
            clearColor,
            clearColor]
        verticalGradient.locations = 
            [0.0, 
            self.frame.minY,
            self.frame.maxY, 
            self.frame.height]
            .map { $0 / self.frame.height }
        horizontalGradient.addSublayer(verticalGradient) 
        //self.superview!.layer.addSublayer(horizontalGradient)
        blurOverlay.layer.mask = horizontalGradient

        
        
        var horizontalLocations : [CGFloat] = []
        var verticalLocations : [CGFloat] = []
        var newAnchor = CGPoint()
        let originalAnchor = self.layer.anchorPoint
        let originalTransform = self.layer.transform
        let zoomScale : CGFloat = 2.0
        
        
        let tapPressGesture = UILongPressGestureRecognizer()
        tapPressGesture.minimumPressDuration = 0.0
        
        tapPressGesture
            .rx_event
            .subscribeNext { tap in
                
                let location = tap.locationInView(self)
                
                switch tap.state {
                case .Began: 
                    
                    let position = self.closestPositionToPoint(location)
                    guard 
                    let range = self.tokenizer.rangeEnclosingPosition(position!, withGranularity: UITextGranularity.Word, inDirection: UITextDirection.min),
                    let word = self.textInRange(range)
                        else {  return }
                    let wordRange = self.textRangeToIntRange(range)
                    guard let wordRect = self.rectForRange(wordRange) else { return }
                    
                    
                    newAnchor = CGPoint(
                        x: wordRect.midX / self.frame.width, 
                        y: wordRect.midY / self.frame.height)
                    
                    //let wordRectInSuperview = self.convertRect(wordRect, toView: self.view)
                    let borderSize = wordRect.height / 3
                    let borderRectInSuperview = wordRect.insetBy(dx: -borderSize, dy: -borderSize)
                    
                    
                    horizontalLocations =
                        [0.0, 
                        borderRectInSuperview.minX, 
                        wordRect.minX,
                        wordRect.maxX, 
                        borderRectInSuperview.maxX,
                        self.frame.width]
                    .map { $0 / self.frame.width }
                    
                    verticalLocations =
                        [0.0, 
                        borderRectInSuperview.minY, 
                            wordRect.minY,
                            wordRect.maxY, 
                            borderRectInSuperview.maxY,
                            self.frame.height]
                            .map { $0 / self.frame.height }
                    
                    events.onNext(.didTapWord( word: word))

                default:
                    print("tap ")
                }   
            }
            
            .addDisposableTo(disposeBag)
        self.addGestureRecognizer(tapPressGesture)   
        
        
        events.subscribeNext { 
            switch $0 {
            case let .doZoomIn(duration: duration):
                print("Start zooming in with \(duration)...")
                
                horizontalGradient.locations = horizontalLocations
                verticalGradient.locations = verticalLocations
                
                UIView.animateWithDuration(1.0, delay: 0.0, options: [], animations: {
                    verticalGradient.colors = [
                        opaqueColor, 
                        opaqueColor, 
                        clearColor, 
                        clearColor, 
                        opaqueColor, 
                        opaqueColor]
                    horizontalGradient.colors = [
                        opaqueColor, 
                        opaqueColor, 
                        clearColor, 
                        clearColor, 
                        opaqueColor, 
                        opaqueColor]
                        
                    self.layer.anchorPoint = newAnchor
                    self.superview!.layer.transform = CATransform3DScale(originalTransform, zoomScale, zoomScale, 1.0) 
                    
                    
                    
                    
                    }, completion: { _ in 
                        
                        events.onNext(.zoomInComplete)
                    })

            case let .doZoomOut(duration: duration):
                print("Start zooming out with \(duration)...")
                
                //horizontalGradient.locations = [0,0,0,0,0,1.0]
                //verticalGradient.locations = [0,0,0,0,0,1.0]
                
                UIView.animateWithDuration(1.0, delay: 5.0, options: [], animations: {
                    
                    self.layer.anchorPoint = originalAnchor
                    self.superview!.layer.transform = originalTransform
                    horizontalGradient.colors = [
                        clearColor,
                        clearColor,
                        clearColor,
                        clearColor,
                        clearColor,
                        clearColor]
                    verticalGradient.colors = [
                        clearColor,
                        clearColor,
                        clearColor,
                        clearColor,
                        clearColor,
                        clearColor]
                    
                    
                    
                    }, completion: { _ in
                        
                    events.onNext(.zoomOutComplete)
                        
                })
                
            case let .doFinish:
                print("zoom finished")
            default:
                break
            }
        }
        
        
        return events
        
    }
}
