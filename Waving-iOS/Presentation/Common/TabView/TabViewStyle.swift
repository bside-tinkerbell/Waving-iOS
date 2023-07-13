//
//  TabViewStyle.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/06/25.
//

import UIKit

public enum TabViewStyle: Equatable {
    
    public enum CellStyle {
        case Legacy(UIColor?)
        case Tier1(UIColor?)
        case Tier2
        
        private var nameLabelNormalStateFont: UIFont {
            switch self {
            case .Legacy:
                return .p_R(16)
            case .Tier1:
                return .p_R(16)
            case .Tier2:
                return .p_R(14)
            }
        }
        
        private var nameLabelNormalStateTextColor: UIColor {
            switch self {
            case .Legacy:
                return .red
            case .Tier1, .Tier2:
                return .gray030
            }
        }
        
        private var nameLabelSelectionStateFont: UIFont {
            .p_B(15)
        }
        
        private var nameLabelSelectionStateTextColor: UIColor {
            .white
        }
        
        public var nameLabelHeight: CGFloat {
            switch self {
            case .Legacy:
                return 18.0
            case .Tier1:
                return 19.0
            case .Tier2:
                return 17.0
            }
        }

        public var nameLabelMinimumLeadingMargin: CGFloat {
            switch self {
            case .Legacy:
                return 19.0
            case .Tier1:
                return 13.0
            case .Tier2:
                return 13.0
            }
        }
        
        public var nameLabelMinimumTrailingMargin: CGFloat {
            switch self {
            case .Legacy:
                return 19.0
            case .Tier1:
                return 13.0
            case .Tier2:
                return 13.0
            }
        }
        
        private var underBarViewNormalStateColor: UIColor { UIColor(hex: "f2f2f2") }
        
        private var underBarViewSelectionStateColor: UIColor { .gray090 }
        
        public func attributedName(_ name: TabViewItemName, isSelectedState: Bool, isEnabledState: Bool) -> NSAttributedString {
            let font = (isSelectedState ? self.nameLabelSelectionStateFont : self.nameLabelNormalStateFont)
            var textColor = (isSelectedState ? self.nameLabelSelectionStateTextColor : self.nameLabelNormalStateTextColor)
            if !isEnabledState {
                textColor = textColor.withAlphaComponent(0.3)
            }
            
            var attributedString: NSMutableAttributedString
            if isSelectedState {
                attributedString = NSMutableAttributedString(attributedString: name.forSelectionState)
            } else {
                attributedString = NSMutableAttributedString(attributedString: name.forNormalState)
            }

            return attributedString.wv_setFont(font).wv_setTextColor(textColor)
        }
        
        public func underBarViewStateColor(isSelectedState: Bool, isEnabledState: Bool) -> UIColor {
            if isSelectedState {
                let color = self.underBarViewSelectionStateColor
                return isEnabledState ? color : color.withAlphaComponent(0.3)
            } else {
                return self.underBarViewNormalStateColor
            }
        }
    }
    
    case Legacy(UIColor?)
    case Tier1(UIColor?)
    case Tier2
    
    public var defaultHeight: CGFloat {
        switch self {
        case .Legacy:
            return 39.0
        case .Tier1:
            return 48.0
        case .Tier2:
            return 40.0
        }
        
    }
    
    public var minimumLineSpacing: CGFloat { 0.0 }
    
    public var minimumInteritemSpacing: CGFloat { 0.0 }
    
    public var compactInsetForSection: UIEdgeInsets { UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0) }
    
    public var regularInsetForSection: UIEdgeInsets { UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0) }
    
    public var cellStyle: CellStyle {
        switch self {
        case .Legacy(let color):
            return .Legacy(color)
        case .Tier1(let color):
            return .Tier1(color)
        case .Tier2:
            return .Tier2
        }
    }
    
    public var backgroundColor: UIColor { .clear }
    
    public var bottomSeparatorViewColor: UIColor {
        switch self {
        case .Legacy:
            return .red
        case .Tier1:
            return .black
        case .Tier2:
            return .gray
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.Legacy, .Legacy), (.Tier1, .Tier1), (.Tier2, .Tier2):
            return true
        default:
            return false
        }
    }
}

public typealias TabViewItemName = (forNormalState: NSMutableAttributedString, forSelectionState: NSMutableAttributedString)
