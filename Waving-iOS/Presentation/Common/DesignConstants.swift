//
//  DesignConstants.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/03.
//

import Foundation

struct Constants {
    enum Intro {
        static let logoImageViewDimension: CGFloat = 180
        
        static let buttonSpacing: CGFloat = 16
        static let loginButtonWidth: CGFloat = 350
        static let loginButtonHeight: CGFloat = 50
        static let loginButtonCornerRadius: CGFloat = 4
    }
    
    enum Navi {
        static let commonPadding: CGFloat = 16
        static let itemSpacing: CGFloat = 14
        static let defaultHeight: CGFloat = 50
    }
    
    enum Home {
        static let logoSize: CGSize = .init(width: 91, height: 21)
        static let rightButtonSize: CGSize = .init(width: 24, height: 24)
    }
}
