//
//  TapToFocusWordProviding.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 15/09/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import RxSwift

public enum TapToFocusWordEvents {
    //Commands
    case doZoomIn(duration: Double)
    case doZoomOut(duration: Double)
    case doFinish
    //Events
    case didTapWord(word: String)
    case zoomInComplete
    case zoomOutComplete
    case didFinish
    case didFail
}

public struct TapToFocusWordConfig {
    public var zoomDuration : Double = 1.0
    public var borderHeightRatio : Double = 1.0
    public init() {
    }
    
    public static var defaultConfig : TapToFocusWordConfig = TapToFocusWordConfig()
}

public protocol TapToFocusWordProviding {
    func addTapToFocusWordFeature(disposeBag: DisposeBag, config: TapToFocusWordConfig?) -> PublishSubject<TapToFocusWordEvents>
}
