//
//  PlayerConfigurator.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PlayerConfigurator {
    
    class func configureModule(media url: URL) -> UIViewController {
        
        let view = PlayerViewController()
        let presenter = PlayerPresenter()
        let interactor = PlayerInteractor()
        let router = PlayerRouter()
        
        let player = VLCMediaPlayer()
        player.media = VLCMedia(url: url)
        player.media.addOptions(["network-caching" : 1000])
        player.delegate = interactor
        
        view.presenter = presenter
        view.modalPresentationStyle = .fullScreen
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.player = player
        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
