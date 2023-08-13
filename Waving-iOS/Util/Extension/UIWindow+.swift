//
//  UIWindow+.swift
//  Waving-iOS
//
//  Created by Jane Choi on 2023/07/30.
//

import UIKit

public extension UIWindow {
    class var wv_keyWindow: UIWindow? {
        guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        
        return currentScene.windows.first
    }
    
    /// key window 의 크기
    class var wv_windowSize: CGSize {
        return self.wv_keyWindow?.frame.size ?? .zero
    }
}
