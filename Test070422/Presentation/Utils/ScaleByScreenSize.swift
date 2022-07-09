//
//  ScaleByScreenSize.swift
//  RxApp
//
//  Created by DatLe on 10/17/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

struct ScaleByScreenSize {
    private var defaultScreenWidth: CGFloat = 375
    private var defaultScreenHeight: CGFloat = 812
    
    private static var shareInstance: ScaleByScreenSize?
    
    private init() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            defaultScreenWidth = 768
            defaultScreenHeight = 1024
        }
    }
    
    static var shared: ScaleByScreenSize! {
        if shareInstance == nil { shareInstance = ScaleByScreenSize() }
        return shareInstance
    }
    
    func scaleHorizontally(value: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return CGFloat(screenWidth * value / defaultScreenWidth)
    }
    
    func scaleVertically(value: CGFloat) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return CGFloat(screenHeight * value / defaultScreenHeight)
    }
}
