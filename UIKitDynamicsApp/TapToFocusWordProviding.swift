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
    case didTapWord(index: Int, word: String)
    case zoomInComplete
    case zoomOutComplete
    case didFinish
}


public protocol TapToFocusWordProviding {
    func addTapToFocusWordFeature() -> PublishSubject<TapToFocusWordEvents>
}
