//
//  Cell+Reuse.swift
//  RxApp
//
//  Created by DatLe on 10/17/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Return the cell's reuse identifier.
    /// The cell's class name and the identifier for reuse must be the same.
    /// - Important: The cell's class name and the identifier for reuse must be the same.
    static var reuseID: String {
        return String(describing: self)
    }
    
    /// Return the xib's file name.
    /// The cell's class name and the xib's file name must be the same.
    /// - Important: The cell's class name and the xib's file name must be the same.
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UICollectionViewCell {
    /// Return the cell's reuse identifier.
    /// The cell's class name and the identifier for reuse must be the same.
    /// - Important: The cell's class name and the identifier for reuse must be the same.
    static var reuseID: String {
        return String(describing: self)
    }
    
    /// Return the xib's file name.
    /// The cell's class name and the xib's file name must be the same.
    /// - Important: The cell's class name and the xib's file name must be the same.
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
