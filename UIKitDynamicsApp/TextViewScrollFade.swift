//
//  TextViewScrollFade.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 26/09/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import CoreMotion
import EasyAnimation



class TextViewScrollFade : UIViewController {
    
    var disposeBag = DisposeBag()
    let container = UIView()
    
    override func viewDidLoad() {

        
        
        self.view.backgroundColor = UIColor.whiteColor()
        let containerView = UIView(frame: view.frame)
        self.view.addSubview(containerView)
        
        
        
        let text = "Cecil was a caterpillar, Cecil was my friend, The last time I saw Cecil He was that big (fingers show a smal size), Oh Cecil, What Have You Been Doing?! I've eaten a whole cabbage leaf. Cecil was a caterpillar, Cecil was my friend, The last time I saw Cecil He was that big (fingers show a larger size), Oh Cecil, What Have You Been Doing?! I've eaten a whole cabbage. Cecil was a caterpillar, Cecil was my friend,The last time I saw Cecil He was that big (fingers show a larger size), Oh Cecil, What Have You Been Doing?! I've eaten a whole cabbage patch. Cecil was a caterpillar, Cecil was my friend, The last time I saw Cecil He was that big (fingers show a large size), Oh Cecil, What Have You Been Doing?!"

        
        let newtextFrame = view.frame.insetBy(dx: 50, dy: 100) 
        let textView = UITextView(frame: newtextFrame)
        textView.center = self.view.center
        
        textView.text = text
        textView.textAlignment = NSTextAlignment.Left
        textView.font = UIFont.systemFontOfSize(30.0);
        textView.editable = false
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.blueColor().CGColor
        textView.backgroundColor = UIColor.clearColor()
        containerView.addSubview(textView)
        
        textView.clipsToBounds = false
        //containerView.clipsToBounds = false
        //containerView.layer.masksToBounds = false
        
        let frame = self.view.bounds
        let clearColor = UIColor.clearColor().CGColor
        let otherColor = UIColor.blackColor().CGColor
        
        let verticalGradient = CAGradientLayer()
        verticalGradient.startPoint = CGPoint(x: 0, y: 0)
        verticalGradient.endPoint = CGPoint(x: 0, y: 1)
        verticalGradient.frame = frame
        let rect = textView.rectForRange(0 ... 6)
        
        
        let vir = UIView(frame: rect!)
        vir.backgroundColor = UIColor.redColor()
        textView.addSubview(vir)
        print(vir)
        
        //let heightOfLine : CGFloat = (textView.rectForRange(0 ... 10)?.height)!        
        //let height = heightOfLine * 3
     
        //let heightOfLineNormalized : CGFloat = height / self.storyTextView.frame.height
        //let bottomHeightNormalised : CGFloat = heightOfLineNormalized * 3
        
        
        
        let wordRectHeightNormalized : CGFloat = 0.3//top of first rect max y
        let bottomWordRectHeightNormalised : CGFloat = wordRectHeightNormalized * 2
        verticalGradient.colors = [
            clearColor, 
            otherColor, 
            otherColor, 
            clearColor]
        verticalGradient.locations = [0.0, wordRectHeightNormalized, bottomWordRectHeightNormalised, 1.0]
        
        containerView.layer.mask = verticalGradient
        

    }

}