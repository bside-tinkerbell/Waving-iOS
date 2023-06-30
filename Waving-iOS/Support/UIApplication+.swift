//
//  UIApplication+.swift
//  Waving-iOS
//
//  Created by Joy on 2023/06/30.
//

import Foundation
import UIKit

extension UIApplication {
    class func getMostTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getMostTopViewController(base: nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController
            { return getMostTopViewController(base: selected) }
        }

        if let presented = base?.presentedViewController {
            return getMostTopViewController(base: presented)
        }
        return base
    }
}
