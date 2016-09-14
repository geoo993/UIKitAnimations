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
    func textRangeToIntRange(textRange: UITextRange) -> Range<Int> {
        let start = self.offsetFromPosition(self.beginningOfDocument, toPosition: textRange.start)
        let end = self.offsetFromPosition(self.beginningOfDocument, toPosition: textRange.end)
        // TODO: Verify that range is NOT start ... end
        return start ..< end
    }
}
