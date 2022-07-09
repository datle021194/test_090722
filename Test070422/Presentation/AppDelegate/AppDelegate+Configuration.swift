//
//  AppDelegate+Configuration.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import Foundation
import IQKeyboardManagerSwift

extension AppDelegate {
    func configureKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func startAppCoordinator() {
        let rootNavigation = UINavigationController()
        
        appCoordinator = AppCoordinator(navigationController: rootNavigation)
        appCoordinator?.start()
    }
    
    func configureWindow() {
        window = WindowUtil.newWindow()
        window?.rootViewController = appCoordinator?.navigationController
        window?.makeKeyAndVisible()
    }
}
