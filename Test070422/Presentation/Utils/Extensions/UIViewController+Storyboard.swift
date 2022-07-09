//
//  UIViewController+Storyboard.swift
//  RxApp
//
//  Created by DatLe on 9/2/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Create new UIViewController from storyboard.
    /// NOTE: The storyboard name, storyboard id and view controller class name should be the same.
    static func newInstance() -> UIViewController {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className)
    }
}
