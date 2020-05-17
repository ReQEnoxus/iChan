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
    var url: URL!
    
    var startedPlaying = false
    
    func playOrPauseToggled() {
        interactor.togglePlayPause()
    }
    
    func sliderDidChangeValue(newValue: Float) {
        interactor.seekPosition(newValue)
    }
    
    func exitButtonPressed() {
        
        interactor.stopPlayer()
        router.dismissPlayer()
    }
    
    func initialSetup() {
        
        view.displayLoadingIndicator()
        interactor.setupPlayer(for: url)
    }
    
    func initialSetupFinished() {
        
        interactor.setDrawableForPlayer(view.playerView)
        view.initialSetupFinished()
    }
    
    //MARK: - Interactor Output
    func updateCurrentTime(time: VLCTime, position: Float) {
        
        if !startedPlaying {
            
            view.removeLoadingIndicator()
            startedPlaying.toggle()
        }
        
        view.setValueForSlider(position)
        view.setValueForTimeLabel(time.stringValue)
    }
}
