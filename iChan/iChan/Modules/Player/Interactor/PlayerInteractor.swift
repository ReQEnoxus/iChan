//
//  PlayerInteractor.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PlayerInteractor: NSObject, PlayerInteractorInput, VLCMediaPlayerDelegate {
    
    var player: VLCMediaPlayer!
    weak var presenter: PlayerInteractorOutput!
    
    private var initialNotify = true
    
    func togglePlayPause() {
        
        if player.isPlaying {
            player.pause()
        }
        else {
            player.play()
        }
    }
    
    func seekPosition(_ position: Float) {
        
        player.position = position
    }
    
    func setDrawableForPlayer(_ drawable: UIView) {
        player.drawable = drawable
    }
    
    //MARK: - PlayerDelegate
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        presenter.updateCurrentTime(time: player.time, position: player.position)
    }
}
