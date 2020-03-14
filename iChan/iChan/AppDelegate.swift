//
//  AppDelegate.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = MainTabBarController()
        
        let boardController = UINavigationController(rootViewController: BoardSelectorConfigurator.configureModule())
        let historyController = UINavigationController(rootViewController: UIViewController())
        let savedController = UINavigationController(rootViewController: UIViewController())
        let settingsController = UINavigationController(rootViewController: UIViewController())
        
        tabBarController.configure(with: [boardController, historyController, savedController, settingsController])
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

