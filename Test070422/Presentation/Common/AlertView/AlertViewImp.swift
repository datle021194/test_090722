//
//  AlertViewImp.swift
//  RxApp
//
//  Created by DatLe on 8/2/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

class AlertViewImp: AlertView {
    private lazy var isAlertShowing = false
    private lazy var alertQueue: [() -> Void] = []
    
    // MARK: - Public
    func show(in vc: UIViewController,
              title: String?,
              message: String,
              cancelTitle: String?,
              cancelAction: (() -> Void)?,
              okTitle: String?,
              okAction: (() -> Void)?) {
        if cancelTitle == nil && okTitle == nil { return }
        
        let action = {
            let alertVC = self.alertController(title: title, message: message, cancelTitle: cancelTitle, cancelAction: cancelAction, okTitle: okTitle, okAction: okAction)
            DispatchQueue.main.async { vc.present(alertVC, animated: true, completion: nil) }
        }

        self.alertQueue.append(action)

        if self.shouldPerformAction() {
            self.isAlertShowing = true
            self.performAction()
        }
    }
    
    func actionSheet(in vc: UIViewController,
                     title: String?,
                     message: String,
                     actions: [(String, (() -> Void)?)]) {
        let action = {
            let alertVC = self.alertController(title: title, message: message, actions: actions)
            DispatchQueue.main.async { vc.present(alertVC, animated: true, completion: nil) }
        }

        self.alertQueue.append(action)

        if self.shouldPerformAction() {
            self.isAlertShowing = true
            self.performAction()
        }
    }
    
    func dismiss() {
        
    }
    
    // MARK: - Private
    private func shouldPerformAction() -> Bool {
        guard self.alertQueue.count > 0 else { return false }
        
        guard !self.isAlertShowing else { return false }
        
        return true
    }
    
    private func performAction() {
        let action = self.alertQueue.removeFirst()
        action()
    }
    
    // MARK: - Alert controller creation
    private func alertController(title: String?,
                                 message: String?,
                                 cancelTitle: String?,
                                 cancelAction: (() -> Void)?,
                                 okTitle: String?,
                                 okAction: (() -> Void)?) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if cancelTitle != nil {
            let alertCancelAction = UIAlertAction(title: cancelTitle!, style: .default) { (action) in
                if let cancel = cancelAction { cancel() }
                
                self.isAlertShowing = false
                
                if self.shouldPerformAction() { self.performAction() }
            }
            
            alertVC.addAction(alertCancelAction)
        }
        
        if okTitle != nil {
            let alertOkAction = UIAlertAction(title: okTitle!, style: .default) { (action) in
                if let ok = okAction { ok() }
                
                self.isAlertShowing = false
                
                if self.shouldPerformAction() { self.performAction() }
            }
            
            alertVC.addAction(alertOkAction)
        }
        
        return alertVC
    }
    
    private func alertController(title: String?,
                                 message: String?,
                                 actions: [(String, (() -> Void)?)]) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.0, style: .default, handler: { _ in
                action.1?()
            })
            alertVC.addAction(alertAction)
        }
        
        return alertVC
    }
}
