//
//  UIView+SafeArea.swift
//  RxApp
//
//  Created by DatLe on 10/8/19.
//  Copyright © 2019 DatLe. All rights reserved.
//

import UIKit

extension UIView {
    func safeInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        } else {
            let statusBarHeight = UIApplication.shared.isStatusBarHidden ? 0.0 : UIApplication.shared.statusBarFrame.size.height
            return UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    func safeFrame() -> CGRect {
        let insets = safeInsets()
        
        var finalFrame = frame
        finalFrame.origin.y = insets.top
        finalFrame.size.height -= (insets.top + insets.bottom)
        
        return finalFrame
    }
}
