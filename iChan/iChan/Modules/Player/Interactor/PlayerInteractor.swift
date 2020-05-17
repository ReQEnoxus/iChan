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
    var videoRepository: VideoRepository!
    var stream: InputStream?
    
    private var initialNotify = true
    
    //MARK: - Interactor Input
    func setupPlayer(for url: URL) {
        
        let player = VLCMediaPlayer()
        
        player.delegate = self
        self.player = player
        
        videoRepository.getVideo(by: url.path) { file in
            
            DispatchQueue.main.async { [weak self] in
                
                if let fileUnwrapped = file, let fileData = fileUnwrapped.fileData, let self = self {
                    
                    self.stream = InputStream(data: fileData)
                    player.media = VLCMedia(stream: self.stream!)
                }
                else {
                    
                    player.media = VLCMedia(url: url)
                    player.media.addOptions(["network-caching" : 1000])
                }
                
                self?.presenter.initialSetupFinished()
            }
        }
    }
    
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
    
    func stopPlayer() {
        
        stream?.close()
        player.stop()
    }
    
    //MARK: - PlayerDelegate
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        presenter.updateCurrentTime(time: player.time, position: player.position)
    }
}
