//
//  PlayerPresenter.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PlayerPresenter: PlayerViewOutput, PlayerInteractorOutput {
    
    weak var view: PlayerViewInput!
    var interactor: PlayerInteractorInput!
    var router: PlayerRouterInput!
    
    func playOrPauseToggled() {
        interactor.togglePlayPause()
    }
    
    func sliderDidChangeValue(newValue: Float) {
        interactor.seekPosition(newValue)
    }
    
    func exitButtonPressed() {
        router.dismissPlayer()
    }
    
    func initialSetup() {
        
        interactor.setDrawableForPlayer(view.playerView)
        view.initialSetupFinished()
    }
    
    //MARK: - Interactor Output
    func updateCurrentTime(time: VLCTime, position: Float) {
        
        view.setValueForSlider(position)
        view.setValueForTimeLabel(time.stringValue)
    }
}
