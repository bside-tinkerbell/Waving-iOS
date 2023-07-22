//
//  FontManager.swift
//  Waving-iOS
//
//  Created by Joy on 2023/05/30.
//

import Foundation
import UIKit

struct FontManager{
    static let shared = FontManager()
    
    enum Pretendard: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semibold = "SemiBold"
    }
    
    func pretendard(_ type: Pretendard, _ size: CGFloat) -> UIFont {
        let name = "Pretendard-" + type.rawValue
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

/// Pretendard Font
extension UIFont {
    static func p_R(_ size: CGFloat) -> UIFont {
        FontManager.shared.pretendard(.regular, size)
    }
    
    static func p_M(_ size: CGFloat) -> UIFont {
        FontManager.shared.pretendard(.medium, size)
    }
    
    static func p_B(_ size: CGFloat) -> UIFont {
        FontManager.shared.pretendard(.bold, size)
    }
    
    static func p_SB(_ size: CGFloat) -> UIFont {
        FontManager.shared.pretendard(.semibold, size)
    }
}
