//
//  AppDelegate.swift
//  Test070422
//
//  Created by Admin on 05/07/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    let apiService: APIService = APIServiceImp()
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureKeyboardManager()
        startAppCoordinator()
        configureWindow()
        return true
    }
}

