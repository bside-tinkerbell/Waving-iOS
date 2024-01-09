//
//  Colors.swift
//  Waving-iOS
//
//  Created by Joy on 2023/05/30.
//

import UIKit

extension UIColor {
    
    enum Main {
        /// #FADC5A
        static var main050: UIColor { return #colorLiteral(red: 0.9803921569, green: 0.862745098, blue: 0.3529411765, alpha: 1) }
        /// #F8D749
        static var main090: UIColor { return #colorLiteral(red: 0.9802921414, green: 0.8646150231, blue: 0.3539540768, alpha: 1) }
        /// #FFFAD9
        static var main010: UIColor { return #colorLiteral(red: 1, green: 0.9815712571, blue: 0.8793492317, alpha: 1) }
    }
    
    enum Text {
        /// #222222
        static var text090: UIColor { return #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1) }
        /// #666666
        static var text050: UIColor { return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) }
        /// #9e9e9e
        static var text030: UIColor { return #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1) }
        /// #FFFFFF
        static var text010: UIColor { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
        /// #2473FC
        static var notice050: UIColor { return #colorLiteral(red: 0.1411764706, green: 0.4509803922, blue: 0.9882352941, alpha: 1) }
        /// #EB1E1E
        static var caution050: UIColor { return #colorLiteral(red: 0.9215686275, green: 0.1176470588, blue: 0.1176470588, alpha: 1) }
        /// #222222 (50%)
        static var dim050: UIColor { return #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 0.5) }
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
        /// #323232
        static var mainButton: UIColor { return #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1) }
    }
    
    // MARK: - Gray Scale
    /// #222222
    static var gray090: UIColor { return #colorLiteral(red: 0.1777858436, green: 0.1777858436, blue: 0.1777858436, alpha: 1) }
    /// #333333
    static var gray080: UIColor { return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) }
    /// #444444
    static var gray070: UIColor { return #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1) }
    /// #555555
    static var gray060: UIColor { return #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1) }
    /// #666666
    static var gray050: UIColor { return #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) }
    /// #828282
    static var gray040: UIColor { return #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1) }
    /// #9E9E9E
    static var gray030: UIColor { return #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1) }
    /// #CFCFCF
    static var gray020: UIColor { return #colorLiteral(red: 0.8117647059, green: 0.8117647059, blue: 0.8117647059, alpha: 1) }
    
    
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
