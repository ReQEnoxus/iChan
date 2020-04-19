//
//  AppDelegate.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import UIKit
import Lightbox
import Lottie
import AVFoundation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let closeButtonTitle = "Закрыть"
    let loadingAnimationName = "loading"
    let loadingViewWidth: CGFloat = 150
    let loadingViewHeight: CGFloat = 150
    let historyModuleName = "История"
    let savedModuleName = "Сохраненные треды"
    
    let vlcPlayer = VLCMediaPlayer()
    
    let threadCache = Cache<String, Thread>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        LightboxConfig.CloseButton.text = closeButtonTitle
        
        LightboxConfig.makeLoadingIndicator = {

            let loadingView = AnimationView()
            loadingView.frame = CGRect(x: .zero, y: .zero, width: self.loadingViewWidth, height: self.loadingViewHeight)
            loadingView.animation = Animation.named(self.loadingAnimationName)
            loadingView.loopMode = .loop
            loadingView.play()
            
            return loadingView
        }
        
        LightboxConfig.handleVideo = { controller, url in
            
            controller.present(PlayerConfigurator.configureModule(media: url), animated: false)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = MainTabBarController()
        
        let boardController = UINavigationController(rootViewController: BoardSelectorConfigurator.configureModule())
        let historyController = UINavigationController(rootViewController: ThreadSelectorConfigurator.configureModule(mode: .cached, title: historyModuleName))
        let savedController = UINavigationController(rootViewController: ThreadSelectorConfigurator.configureModule(mode: .realm, title: savedModuleName))
        let settingsController = PlayerViewController()
        
        tabBarController.configure(with: [boardController, historyController, savedController, settingsController])
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

