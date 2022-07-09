//
//  UIView+Language.swift
//  RxApp
//
//  Created by DatLe on 1/25/21.
//  Copyright © 2021 DatLe. All rights reserved.
//

import UIKit

extension UIView {
    func listenLanguageChange(notificationName name: Notification.Name, selector aSelector: Selector) {
        NotificationCenter.default.addObserver(self, selector: aSelector, name: name, object: nil)
    }
    
    func removeLanguageChangeNotification(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
}
