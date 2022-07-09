//
//  LoadingViewImp.swift
//  RxApp
//
//  Created by DatLe on 5/2/19.
//  Copyright © 2019 DatLe. All rights reserved.
//

import UIKit

class LoadingViewImp: LoadingView {
    private var indicatorColor: UIColor = UIColor(white: 1.0, alpha: 1.0)
    private var backgroundColor: UIColor = UIColor(white: 0.0, alpha: 0.35)
    private var indicatorImage: UIImage?
    private var indicatorImageSize = CGSize(width: 40, height: 40)
    
    private let animationDuration = 0.25
    private var hasLoadingView = false
    private var isCustomIndicator = false
    
    private var indicator: UIActivityIndicatorView?
    private var indicatorImageView: UIImageView?
    
    private var _loadingViewContainer: UIView?
    private var loadingViewContainer: UIView {
        if hasLoadingView { return _loadingViewContainer! }
        
        _loadingViewContainer = view()
        hasLoadingView = true
        
        if let customImage = indicatorImage {
            isCustomIndicator = true
            
            indicatorImageView = UIImageView()
            indicatorImageView?.contentMode = .scaleAspectFit
            indicatorImageView?.image = customImage
            
            _loadingViewContainer!.addSubview(indicatorImageView!)
            constraintCustomIndicator()
        } else {
            isCustomIndicator = false
            
            indicator = indicatorView()
            indicator!.center = _loadingViewContainer!.center
            _loadingViewContainer!.addSubview(indicator!)
        }
        
        WindowUtil.mainWindow?.addSubview(_loadingViewContainer!)
        return _loadingViewContainer!
    }
    
    private static var _shared: LoadingViewImp?
    
    static var shared: LoadingViewImp {
        if _shared == nil { _shared = LoadingViewImp() }
        return _shared!
    }
    
    private init() {}
    
    func setIndicatorColor(_ color: UIColor) {
        indicatorColor = color
    }
    
    func setBackgoundColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    func setIndicatorImage(_ image: UIImage?) {
        indicatorImage = image
    }
    
    func setIndicatorImageSize(_ size: CGSize) {
        indicatorImageSize = size
    }
    
    func show() {
        loadingViewContainer.isHidden = false
        WindowUtil.mainWindow?.bringSubviewToFront(loadingViewContainer)
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.loadingViewContainer.backgroundColor = self.backgroundColor
        }, completion: { isFinished in
            if isFinished {
                if self.isCustomIndicator {
                    self.animatingCustomIndicator()
                } else {
                    self.indicator?.startAnimating()
                }
            }
        })
    }
    
    func hide() {
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.loadingViewContainer.backgroundColor = .clear
        }, completion: { isFinished in
            if isFinished {
                if self.isCustomIndicator {
                    self.stopAnimatingCustomIndicator()
                } else {
                    self.indicator?.stopAnimating()
                }
                
                self.loadingViewContainer.isHidden = true
            }
        })
    }
    
    private func view() -> UIView {
        let contentView = UIView(frame: UIScreen.main.bounds)
        contentView.backgroundColor = .clear
        return contentView
    }
    
    private func indicatorView() -> UIActivityIndicatorView {
        var style: UIActivityIndicatorView.Style!
        if #available(iOS 13.0, *) {
            style = .large
        } else {
            style = .whiteLarge
        }
        
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = indicatorColor
        indicator.hidesWhenStopped = true
        
        return indicator
    }
    
    private func constraintCustomIndicator() {
        guard let customIndicator = indicatorImageView else { return }
        guard let parentView = customIndicator.superview else { return }
        
        let with = customIndicator.widthConstraint(indicatorImageSize.width)
        let height = customIndicator.heightConstraint(indicatorImageSize.height)
        let centerX = customIndicator.centerXConstraint(to: parentView)
        let centerY = customIndicator.centerYConstraint(to: parentView)
        
        NSLayoutConstraint.activate([
            with,
            height,
            centerX,
            centerY
        ])
    }
    
    private func animatingCustomIndicator() {
        guard let customIndicator = indicatorImageView else { return }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0.0
        rotation.toValue = Float.pi * 2
        rotation.duration = 0.7
        rotation.repeatCount = Float.greatestFiniteMagnitude
        
        customIndicator.layer.add(rotation, forKey: nil)
    }
    
    private func stopAnimatingCustomIndicator() {
        guard let customIndicator = indicatorImageView else { return }
        customIndicator.layer.removeAllAnimations()
    }
}
