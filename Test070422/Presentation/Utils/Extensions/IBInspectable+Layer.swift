//
//  IBInspectable+Layer.swift
//  RxApp
//
//  Created by DatLe on 10/23/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var borderWith: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            
            return UIColor(cgColor: color)
        }
        
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
}
