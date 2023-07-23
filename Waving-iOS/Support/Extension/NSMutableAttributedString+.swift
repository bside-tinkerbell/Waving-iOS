//
//  NSMutableAttributedString+.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/08.
//

import UIKit

public extension NSMutableAttributedString {
    @discardableResult
    func wv_addAttributes(_ attributes: [NSAttributedString.Key: Any], range: NSRange? = nil) -> Self {
        self.addAttributes(attributes, range: range ?? .init(location: 0, length: self.length))
        return self
    }
    
    @discardableResult
    func wv_setFont(_ font: UIFont, range: NSRange? = nil) -> Self {
        self.wv_addAttributes([.font: font], range: range)
    }
    
    @discardableResult
    func wv_setTextColor(_ color: UIColor, range: NSRange? = nil) -> Self {
        self.wv_addAttributes([.foregroundColor: color], range: range)
    }
    
    @discardableResult
    func wv_setParagraphStyle(alignment: NSTextAlignment = .natural, lineBreakMode: NSLineBreakMode = .byWordWrapping) -> Self {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        return self.wv_addAttributes([.paragraphStyle: paragraphStyle])
    }
}
