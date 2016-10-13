//
//  HighScoreController.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 12/10/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation

import UIKit
import RxCocoa
import RxSwift
import CoreMotion
import EasyAnimation


class HighScoreController : UIViewController {
    
    var disposeBag = DisposeBag()
    
    var scoreLabel = UILabel()
    var highScoreLabel = UILabel()
    
    var score = 0
    var highScore = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor().colorWithAlphaComponent(0.8)
        
        let highScoreDefault = NSUserDefaults.standardUserDefaults()
        let hightS = (highScoreDefault.valueForKey("HighScore") as? NSInteger)
        if let latestScore = hightS where hightS != nil {
            highScore = latestScore
        }else{
            highScore = 0
        }
        
        
        let scoreFrame = CGRect(x: self.view.center.x - 100, 
                                y: self.view.center.y - 100, 
                                width: 200, height: 100)
        scoreLabel = UILabel(frame: scoreFrame)
        scoreLabel.font = UIFont (name: "HelveticaNeue-UltraLight", size: 20)
        scoreLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(scoreLabel)
        
        
        let highScoreFrame = CGRect(x: self.view.center.x - 100, 
                                    y: self.view.center.y - 70, 
                                    width: 200, height: 100)
        highScoreLabel = UILabel(frame: highScoreFrame)
        highScoreLabel.font = UIFont (name: "HelveticaNeue-UltraLight", size: 20)
        highScoreLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(highScoreLabel)
        
        updateTexts()
        
        
        let buttonFrame = CGRect(x: self.view.center.x - 100, 
                                    y: self.view.center.y + 100, 
                                    width: 200, height: 50)
        
        let resetButton = UIButton(type: UIButtonType.RoundedRect)
        resetButton.frame =  buttonFrame
        resetButton.titleLabel?.font = UIFont (name: "Arial", size: 20)
        resetButton.titleLabel?.lineBreakMode = .ByWordWrapping
        resetButton.titleLabel?.textAlignment = .Center
        resetButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        resetButton.tintColor = UIColor.brownColor()
        resetButton.backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.6)
        resetButton.layer.cornerRadius = 6
        resetButton.setTitle("RESET BUTTON", forState: UIControlState.Normal)
        resetButton.addTarget(self, action: #selector(resetButtonAction), forControlEvents: .TouchUpInside)
        
        
        let counterbuttonFrame = CGRect(x: self.view.center.x - 100, 
                                 y: self.view.center.y + 180, 
                                 width: 200, height: 50)
        
        let counterButton = UIButton(type: UIButtonType.RoundedRect)
        counterButton.frame =  counterbuttonFrame
        counterButton.titleLabel?.font = UIFont (name: "Arial", size: 20)
        counterButton.titleLabel?.lineBreakMode = .ByWordWrapping
        counterButton.titleLabel?.textAlignment = .Center
        counterButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        counterButton.tintColor = UIColor.brownColor()
        counterButton.backgroundColor = UIColor.orangeColor().colorWithAlphaComponent(0.6)
        counterButton.layer.cornerRadius = 6
        counterButton.setTitle("COUNTER BUTTON", forState: UIControlState.Normal)
        counterButton.addTarget(self, action: #selector(counterbuttonAction), forControlEvents: .TouchUpInside)
        
        
        
        self.view.addSubview(resetButton)
        self.view.addSubview(counterButton)
    }
    
    func updateTexts(){
        scoreLabel.text = NSString(format: "Score :  %i", score) as String
        highScoreLabel.text = NSString(format: "High Score :  %i", highScore) as String
    }
    
    func counterbuttonAction(sender: UIButton!) {
        
        score += 1
        if(score > highScore){
            highScore = score
            
            let highScoreDefault = NSUserDefaults.standardUserDefaults()
            highScoreDefault.setValue(highScore, forKey: "HighScore")
            highScoreDefault.synchronize()
        }
        
        updateTexts()
        print("Counter Button tapped")
    }
    
    func resetButtonAction(sender: UIButton!) {
        
        score = 0
        updateTexts()
        print("Reset Button tapped")
    }

}