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
    }
    
    func pretendard(_ type: Pretendard, _ size: CGFloat) -> UIFont {
        let name = "Pretendared-" + type.rawValue
        return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
