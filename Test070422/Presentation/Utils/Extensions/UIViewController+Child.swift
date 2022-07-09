//
//  UIViewController+Child.swift
//  RxApp
//
//  Created by DatLe on 11/9/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Extension: add a view controller and it's view to another view controller.
    func addChildViewController(_ child: UIViewController,
                                parentView: UIView? = nil,
                                constraints: [NSLayoutConstraint]? = nil,
                                duration: Double = 0.3,
                                completion: (() -> Void)? = nil) {
        let containerView: UIView! = parentView ?? view
        
        child.view.layer.opacity = 0.0
        addChild(child)
        containerView.addSubview(child.view)
        NSLayoutConstraint.activate(constraints ?? child.view.constraintsToSuper())
        child.didMove(toParent: self)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            child.view.layer.opacity = 1.0
        }, completion: { isFinished in
            if isFinished {
                completion?()
            }
        })
    }
    
    /// Extension: remove a view controller and it's view from it's parent view controller.
    func removeChildViewController(_ child: UIViewController,
                                   duration: Double = 0.3,
                                   completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            child.view.layer.opacity = 0.0
        }, completion: { isFinished in
            if isFinished {
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
                completion?()
            }
        })
    }
}
