//
//  BlurMaskViewController.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 28/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import CoreMotion


class BlurMaskViewController :UIViewController, UIScrollViewDelegate {
    
    
    
    var  blurMask = UIView()
    var  blurredBgImage = UIImageView()
    
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//                if self {
//                    // Custom initialization
//                }
//                return self
//        
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor.randomColor()
    }

    override func loadView() {
        
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        
        /*::::::::::::::::::: Create Basic View Components ::::::::::::::::::::::*/
        // content view
        self.view.addSubview(self.createContentView())
        
        // header view
        self.view.addSubview(self.createHeaderView())
        
        // slide view
        self.view.addSubview(self.createScrollView())
        
        /*:::::::::::::::::::::::: Create Blurred View ::::::::::::::::::::::::::*/
        // Blurred with UIImage+ImageEffects
        blurredBgImage.image = self.blurWithImageEffects(self.takeSnapshotOfView(self.createContentView()))
        
        // Blurred with Core Image
        //blurredBgImage.image = self.blurWithCoreImage(self.takeSnapshotOfView(self.createContentView()))
        
        // Blurring with GPUImage framework
        // blurredBgImage.image = [self blurWithGPUImage:[self takeSnapshotOfView:[self createContentView]]];
        
        
        /*::::::::::::::::::: Create Mask for Blurred View :::::::::::::::::::::*/
        blurMask = UIView(frame: CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 0))
        blurMask.backgroundColor = UIColor.whiteColor()
        blurredBgImage.layer.mask = blurMask.layer

    }
    
    func scrollViewDidScroll(scrollView : UIScrollView )
    {
        let frameX : CGFloat = blurMask.frame.origin.x
        let frameY : CGFloat = self.view.frame.size.height - 50 - scrollView.contentOffset.y
        let width : CGFloat = blurMask.frame.size.width
        let height : CGFloat = blurMask.frame.size.height + scrollView.contentOffset.y
        blurMask.frame = CGRectMake(frameX,frameY,width,height)
        
    }
    
    func takeSnapshotOfView(view:UIView) -> UIImage {
    
        //reduce the size of the snapshot that we apply the blur filter on
        let reductionFactor: CGFloat = 1.25
        UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width/reductionFactor, view.frame.size.height/reductionFactor))
        view.drawViewHierarchyInRect(CGRectMake(0, 0, view.frame.size.width/reductionFactor, view.frame.size.height/reductionFactor), afterScreenUpdates: true)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    
//    func blurWithGPUImage (sourceImage : UIImage) -> UIImage
//    {
//        //let blurFilter : GPUImageGaussianBlurFilter = GPUImageGaussianBlurFilter()
//        //blurFilter.blurRadiusInPixels = 30.0
//        
//        
//        
//        //    let blurFilter : GPUImageBoxBlurFilter = GPUImageBoxBlurFilter()
//        //    blurFilter.blurRadiusInPixels = 20.0;
//        
//        //    let blurFilter : GPUImageiOSBlurFilter = GPUImageiOSBlurFilter()
//        //    blurFilter.saturation = 1.5;
//        //    blurFilter.blurRadiusInPixels = 30.0;
//        
//        //return [blurFilter imageByFilteringImage: sourceImage];
//
//    }
    
    func blurWithCoreImage (sourceImage: UIImage) -> UIImage {
       
        
        let inputImage = CIImage(image: sourceImage)
        
        // Apply Affine-Clamp filter to stretch the image so that it does not look shrunken when gaussian blur is applied
        
        let transform: CGAffineTransform = CGAffineTransformIdentity
        let clampFilter : CIFilter = CIFilter(name: "CIAffineClamp")! 
            
        clampFilter.setValue(inputImage, forKey: "inputImage")
        let value = NSValue(CGAffineTransform: transform)
        clampFilter.setValue(value, forKey: "inputTransform")
            
        
        // Apply gaussian blur filter with radius of 30
        let gaussianBlurFilter : CIFilter = CIFilter(name: "CIGaussianBlur")!
        gaussianBlurFilter.setValue(clampFilter.outputImage , forKey: "inputImage")
        gaussianBlurFilter.setValue(30, forKey: "inputRadius")
        
        let context : CIContext = CIContext(options: nil)
        let cgImage : CGImageRef = context.createCGImage(gaussianBlurFilter.outputImage!, fromRect: (inputImage?.extent)!)
        
        
        // Set up output context.
        UIGraphicsBeginImageContext(self.view.frame.size)
        let outputContext: CGContextRef = UIGraphicsGetCurrentContext()!
        
        // Invert image coordinates
        CGContextScaleCTM(outputContext, 1.0, -1.0)
        CGContextTranslateCTM(outputContext, 0, -self.view.frame.size.height)

        // Draw base image.
        CGContextDrawImage(outputContext, self.view.frame, cgImage)
        // Apply white tint
        CGContextSaveGState(outputContext)
        CGContextSetFillColorWithColor(outputContext, UIColor(white: 1, alpha: 0.2).CGColor)
        CGContextFillRect(outputContext, self.view.frame)
        CGContextRestoreGState(outputContext)
        // Output image is ready.
        let outputImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage;
        
    }
 
    func blurWithImageEffects(image:UIImage) -> UIImage {
    
        let blurRadius : CGFloat = 30
        let tintColor : UIColor = UIColor(white: 1, alpha: 0.2)
        let saturation : CGFloat = 1.5
        
        return image.applyBlurWithRadius(blurRadius, tintColor: tintColor, saturationDeltaFactor:saturation, maskImage: nil)!

        
    }
    func createHeaderView () -> UIView 
    {
     
        let headerView: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 60))
        headerView.backgroundColor = UIColor(red: 229/255.0, green: 39/255.0, blue: 34/255.0, alpha: 0.6)
        let title: UILabel = UILabel(frame: CGRectMake(0, 20, self.view.frame.size.width, 40))
        
        title.text = "Dynamic Blur Demo"
        title.textColor = UIColor(white: 1, alpha: 1)
        title.font = UIFont(name: "HelveticaNeue", size: 20)
        title.textAlignment = NSTextAlignment.Center
        headerView.addSubview(title)
        return headerView


    }
    
    func createContentView () -> UIView {
        
        // Background image
        let contentView: UIView = UIView(frame: self.view.frame)
        let contentImage: UIImageView = UIImageView(frame: contentView.frame)
        contentImage.image = UIImage(named:"demo-bg")
        contentView.addSubview(contentImage)
        
        let creditsViewContainer: UIView = UIView(frame: CGRectMake(self.view.frame.size.width/2-65, 335, 130, 130))
        creditsViewContainer.backgroundColor = UIColor.whiteColor()
        creditsViewContainer.layer.cornerRadius = 65
        contentView.addSubview(creditsViewContainer)
        
        let photoTitle: UILabel = UILabel(frame: CGRectMake(0, 54, 130, 18))
        photoTitle.text = "Peach Garden"
        photoTitle.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        photoTitle.textAlignment = NSTextAlignment.Center
        photoTitle.textColor = UIColor(white: 0.4, alpha: 1)
        creditsViewContainer.addSubview(photoTitle)
        
        let photographer: UILabel = UILabel(frame: CGRectMake(0, 72, 130, 9))
        photographer.text = "by Cas Cornelissen"
        photographer.font = UIFont(name: "HelveticaNeue-Thin", size: 9)
        photographer.textAlignment = NSTextAlignment.Center
        photographer.textColor = UIColor(white: 0.4, alpha: 1)
        creditsViewContainer.addSubview(photographer)
        return contentView
        

    }
    
    func createScrollView() -> UIView {
    
       
        
        let containerView: UIView = UIView(frame: self.view.frame)
        blurredBgImage = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, 568))
        blurredBgImage.contentMode = UIViewContentMode.ScaleToFill
        containerView.addSubview(blurredBgImage)
        
        let scrollView: UIScrollView = UIScrollView(frame: self.view.frame)
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height*2)-110)
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        containerView.addSubview(scrollView)
        
        ///slider content holder
        let slideContentView: UIView = UIView(frame: CGRectMake(0, 518 , self.view.frame.size.width, 508))
        slideContentView.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(slideContentView)
        
        // slider title
        let slideUpLabel: UILabel = UILabel(frame: CGRectMake(0, 6, self.view.frame.size.width, 50))
        slideUpLabel.text = "Photo information"
        slideUpLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        slideUpLabel.textAlignment = NSTextAlignment.Center
        slideUpLabel.textColor = UIColor(white: 0, alpha: 0.5)
        slideContentView.addSubview(slideUpLabel)
        
        // slider arrow icon
        let slideUpImage: UIImageView = UIImageView(frame: CGRectMake((self.view.frame.size.width/2)-12, 4, 24, 22.5))
        slideUpImage.image = UIImage(named:"up-arrow.png")
        slideContentView.addSubview(slideUpImage)
        
        // slider text content
        let detailsText: UITextView = UITextView(frame: CGRectMake(25, 100, 270, 350))
        detailsText.backgroundColor = UIColor.clearColor()
        detailsText.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        detailsText.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        detailsText.textAlignment = NSTextAlignment.Center
        detailsText.textColor = UIColor(white: 0, alpha: 0.6)
        slideContentView.addSubview(detailsText)
        
        return containerView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
