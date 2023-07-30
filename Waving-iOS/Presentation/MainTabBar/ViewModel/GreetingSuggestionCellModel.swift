//
//  GreetingSuggestionCellModel.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/29.
//

import UIKit

final class GreetingSuggestionCellModel {
    @Published var titleAttributedText: NSAttributedString
    
    private lazy var width: CGFloat = {
        var width: CGFloat = UIWindow.wv_windowSize.width
        
        // left padding
        width -= 20
        // right padding
        width -= 20
        
        return width
    }()
    
    lazy var size: CGSize = {
        
        Log.d("[jane] title: \(titleAttributedText)")
        
        if titleAttributedText.isEmpty {
            return .zero
        }
        
        var labelWidth: CGFloat = width
        labelWidth -= 20 // left padding
        labelWidth -= 20 // right padding
        labelWidth -= 24 // copy button width
        
        let boundingSize = titleAttributedText.wv_size(for: 1.26, constrainedTo: CGSize(width: labelWidth, height: .greatestFiniteMagnitude))
        var height = ceil(boundingSize.height)
        
        height += 20.0 // top padding
        height += 20.0 // bottom padding
        
        Log.d("[jane] labelWidth: \(labelWidth)")
        Log.d("[jane] boundingSize: \(boundingSize)")
        Log.d("[jane] width: \(width), height: \(height)")
        return .init(width: width, height: height)
    }()
    
    init(title: String) {
        self.titleAttributedText = NSMutableAttributedString(string: title)
            .wv_setFont(.p_R(16))
            .wv_setTextColor(.text090)
            .wv_setParagraphStyle(lineHeightMultiple: 1.26)
    }
    
}
