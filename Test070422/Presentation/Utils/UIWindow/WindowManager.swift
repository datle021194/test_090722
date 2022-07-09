
//
//  WindowManager.swift
//  RxApp
//
//  Created by DatLe on 10/21/20.
//  Copyright © 2020 DatLe. All rights reserved.
//

import UIKit

class WindowManager {
    private static var shareInstance: WindowManager?
    private init() {}
    
    private var newWindow: UIWindow?
    
    static var shared: WindowManager! {
        if shareInstance == nil { shareInstance = WindowManager() }
        return shareInstance!
    }
    
    func makeKeyAndVisible(rootViewController vc: UIViewController) {
        if newWindow == nil { newWindow = WindowUtil.newWindow() }
        newWindow?.rootViewController = vc
        newWindow?.makeKeyAndVisible()
    }
    
    func close() {
        WindowUtil.mainWindow?.makeKeyAndVisible()
        newWindow?.rootViewController = nil
        newWindow = nil
    }
}
