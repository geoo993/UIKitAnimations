//
//  UITextView+Ext.swift
//  UIKitAnimations
//
//  Created by GEORGE QUENTIN on 14/09/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    public func textRangeToIntRange(textRange: UITextRange) -> Range<Int> {
        let start = self.offsetFromPosition(self.beginningOfDocument, toPosition: textRange.start)
        let end = self.offsetFromPosition(self.beginningOfDocument, toPosition: textRange.end)
        // TODO: Verify that range is NOT start ... end
        return start ..< end
    }
    
    private var kWordHighlightHeightScale : CGFloat { return 0.9 }
    public func rectForRange(range: Range<Int>) -> CGRect? {
        if let
            start   = self.positionFromPosition(self.beginningOfDocument, offset: range.startIndex),
            end     = self.positionFromPosition(self.beginningOfDocument, offset: range.endIndex) {
            
            let textRange = self.textRangeFromPosition(start, toPosition: end)
            var rect = self.firstRectForRange(textRange!)
            let offset = self.contentOffset
            let lineSpace : CGFloat = 0.0//StoryTweaks.assign(StoryTweaks.textViewVerticalLineSpace)
            let height = kWordHighlightHeightScale * (rect.height - lineSpace)
            let yOffset = (1.0 - kWordHighlightHeightScale) * (rect.height - lineSpace)
            rect.offsetInPlace(dx: 0, dy: -offset.y + yOffset)
            rect.size = CGSize(width: rect.width, height: height)
            return rect
        } else {
            return nil
        }
    }
}
