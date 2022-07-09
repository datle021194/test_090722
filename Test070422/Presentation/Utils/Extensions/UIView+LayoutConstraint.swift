//
//  UIView+LayoutConstraint.swift
//  RxApp
//
//  Created by DatLe on 7/18/19.
//  Copyright © 2019 DatLe. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - Constraints for view - super view
    func leftToSuper(relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        guard let superView = self.superview else { fatalError() }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: superView, attribute: .leading, multiplier: 1, constant: constant)
    }
    
    func rightToSuper(relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        guard let superView = self.superview else { fatalError() }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return NSLayoutConstraint(item: superView, attribute: .trailing, relatedBy: relation, toItem: self, attribute: .trailing, multiplier: 1, constant: constant)
    }
    
    func topToSuper(relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        guard let superView = self.superview else { fatalError() }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: superView, attribute: .top, multiplier: 1, constant: constant)
    }
    
    func bottomToSuper(relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        guard let superView = self.superview else { fatalError() }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return NSLayoutConstraint(item: superView, attribute: .bottom, relatedBy: relation, toItem: self, attribute: .bottom, multiplier: 1, constant: constant)
    }
    
    func constraintsToSuper(_ constant: CGFloat = 0) -> [NSLayoutConstraint] {
        let top = topToSuper(constant: constant)
        let left = leftToSuper(constant: constant)
        let bottom = bottomToSuper(constant: constant)
        let right = rightToSuper(constant: constant)
        return [top, left, bottom, right].compactMap({ $0 })
    }
    
    // MARK: - Constraints for view - view
    func leadingConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .left, relatedBy: relation, toItem: view, attribute: .right, multiplier: 1, constant: constant)
    }
    
    func trailingConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal,constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .right, relatedBy: relation, toItem: view, attribute: .left, multiplier: 1, constant: constant)
    }
    
    func leftConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .left, relatedBy: relation, toItem: view, attribute: .left, multiplier: 1, constant: constant)
    }
    
    func rightConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal,constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .right, relatedBy: relation, toItem: view, attribute: .right, multiplier: 1, constant: constant)
    }
    
    func topVerticalSpaceConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: view, attribute: .bottom, multiplier: 1, constant: constant)
    }
    
    func bottomVerticalSpaceConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: view, attribute: .top, relatedBy: relation, toItem: self, attribute: .bottom, multiplier: 1, constant: constant)
    }
    
    func topConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: view, attribute: .top, multiplier: 1, constant: constant)
    }
    
    func bottomConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: view, attribute: .bottom, multiplier: 1, constant: constant)
    }
    
    // MARK: - Constraints for width and height
    func widthConstraint(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal)  -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .width, multiplier: 1, constant: constant)
    }
    
    func widthRatioConstraint(with view: UIView, multiplier: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: multiplier,
            constant: 0
        )
    }
    
    func heightConstraint(_ constant: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: relation,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: constant
        )
    }
    
    func heightRatioConstraint(with view: UIView, multiplier: CGFloat) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: multiplier,
            constant: 0
        )
    }
    
    func constraint(
        attribute firstAttribute: NSLayoutConstraint.Attribute,
        to view: UIView,
        attribute secondAttribute: NSLayoutConstraint.Attribute,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(
            item: self,
            attribute: firstAttribute,
            relatedBy: .equal,
            toItem: view,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
    }
    
    // MARK: - Constraints for vertical center and horizontal center
    func centerXConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: view, attribute: .centerX, multiplier: 1, constant: constant)
    }
    
    func centerYConstraint(to view: UIView, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: view, attribute: .centerY, multiplier: 1, constant: constant)
    }
}
