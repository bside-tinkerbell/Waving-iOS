//
//  UIAlertController+.swift
//  Waving-iOS
//
//  Created by Jane Choi on 12/3/23.
//

import UIKit

public typealias UIAlertActionHandler = (UIAlertAction) -> Void
public typealias UIAlertActionTuple = (title: String, handler: UIAlertActionHandler?)

extension UIAlertController {
    @discardableResult
    static func wv_presentAlert(with alertData: AlertData) -> UIAlertController {
        let alertController = UIAlertController(title: alertData.title, message: alertData.message, preferredStyle: .alert)
        
        if let defaultActions = alertData.defaultActions {
            defaultActions.forEach { alertController.addAction($0) }
        }
        
        if let cancelAction = alertData.cancelAction {
            alertController.addAction(cancelAction)
        }
        
        if let destructiveAction = alertData.destructiveAction {
            alertController.addAction(destructiveAction)
        }
        
        alertData.presentingViewController.present(alertController, animated: true, completion: nil)
        
        return alertController
    }
}

struct AlertData {
    
    let presentingViewController: UIViewController
    let title: String?
    let message: String?
    let defaultActions: [UIAlertAction]?
    let cancelAction: UIAlertAction?
    let destructiveAction: UIAlertAction?
    
    static let oKTitle = "OK"
    static let cancelTitle = "Cancel"
    
    public init(on presentingViewController: UIViewController,
                title: String? = nil,
                message: String? = nil,
                defaultActionTuples: [UIAlertActionTuple]? = nil,
                cancelActionTuple: UIAlertActionTuple? = nil,
                destructiveActionTuple: UIAlertActionTuple? = nil) {
        self.presentingViewController = presentingViewController
        self.title = title
        self.message = message
        self.defaultActions = defaultActionTuples?.map { UIAlertAction(title: $0.title, style: .default, handler: $0.handler) }
        self.cancelAction = (cancelActionTuple != nil) ? UIAlertAction(title: cancelActionTuple?.title, style: .cancel, handler: cancelActionTuple?.handler) : nil
        self.destructiveAction = (destructiveActionTuple != nil) ? UIAlertAction(title: destructiveActionTuple?.title, style: .destructive, handler: destructiveActionTuple?.handler) : nil
    }
}
