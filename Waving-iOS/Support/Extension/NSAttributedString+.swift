//
//  NSAttributedString.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/30.
//

import UIKit

public extension NSAttributedString {
    
    var isEmpty: Bool {
        self.string.isEmpty
    }
    
    func wv_size(for lineHeightMultiple: CGFloat, constrainedTo size: CGSize) -> CGSize {
        
        guard let mutableCopy = self.mutableCopy() as? NSMutableAttributedString, !self.string.isEmpty else {
            return .zero
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        mutableCopy.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableCopy.string.count))
        return mutableCopy.boundingRect(with: size, options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine], context: nil).size
    }
}
