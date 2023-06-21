//
//  UIColor+.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/03.
//

import UIKit

extension UIColor {
    enum Text {
        static let black = UIColor.black
        static let white = UIColor.white
    }
    
    enum Border {
        static let gray = UIColor(named: "button_border")!
    }
    
    enum Background {
        static let white = UIColor(named: "main_background")!
    }
    
    enum Button {
        static let blackBackground = UIColor.black
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex) // 문자 파서역할을 하는 클래스
        _ = scanner.scanString("#")  // scanString은 iOS13 부터 지원
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
    }
}
