//
//  WindowUtil.swift
//  RxApp
//
//  Created by DatLe on 10/29/19.
//  Copyright © 2019 DatLe. All rights reserved.
//

import UIKit

struct WindowUtil {
    private static var _isSceneAdopted: Bool?
    
    /// Use to check if the app is adopted the scene.
    static var isSceneAdopted: Bool {
        if _isSceneAdopted != nil { return _isSceneAdopted! }
        
        guard let infoPlist = Bundle.main.infoDictionary else { fatalError("Couldn't load the plist file") }
        
        let checkingKey = "UIApplicationSceneManifest"
        let checkingValue = infoPlist[checkingKey]
        
        _isSceneAdopted = checkingValue != nil
        
        return _isSceneAdopted!
    }
    
    /// Return the window scene that is running in the foreground
    /// and is currently receiving events.
    @available(iOS 13.0, *)
    static var activeScene: UIWindowScene? {
        guard isSceneAdopted else { return nil }
        
        return UIApplication.shared.connectedScenes.filter({
            $0.activationState == .foregroundActive
        }).first as? UIWindowScene
    }
    
    /// Return the window that is running in the foreground
    /// and is currently receiving events.
    static var activeWindow: UIWindow? {
        if #available(iOS 13.0, *), isSceneAdopted {
            guard let activeScene = activeScene else { return nil }
            return activeScene.windows.filter({ $0.isKeyWindow == true }).first
        } else {
            return UIApplication.shared.windows.filter({ $0.isKeyWindow == true }).first
        }
    }
    
    /// Return the application's window(belong to AppDelegate/SceneDelegate).
    static var mainWindow: UIWindow? {
        if #available(iOS 13.0, *), isSceneAdopted {
            guard let activeScene = activeScene else { return nil }
            
            guard let sceneDelegate = activeScene.windows.filter({
                $0.windowScene != nil && $0.windowScene is UIWindowSceneDelegate
            }).first else { return nil }
            
            return sceneDelegate.window
        } else {
            return (UIApplication.shared.delegate as! AppDelegate).window
        }
    }
    
    /// Create a new window.
    /// The window is associated with active scene if it adopted the scene.
    static func newWindow() -> UIWindow? {
        if #available(iOS 13.0, *), isSceneAdopted {
            guard let activeScene = activeScene else { return nil }
            return UIWindow(windowScene: activeScene)
        } else {
            return UIWindow(frame: UIScreen.main.bounds)
        }
    }
}
