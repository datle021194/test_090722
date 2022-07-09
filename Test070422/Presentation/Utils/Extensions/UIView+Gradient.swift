//
//  UIView+Gradient.swift
//  RxApp
//
//  Created by DatLe on 10/15/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Add a left to right linear gradient layer to the view.
    /// The layer will be added at index 0.
    func addLTRLinearGradient(withColors colors: [CGColor], locations: [NSNumber]? = nil, cornerRadius: CGFloat = 0) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.locations = locations
        gradient.colors = colors
        gradient.cornerRadius = cornerRadius
        
        layer.insertSublayer(gradient, at: 0)
    }
}
