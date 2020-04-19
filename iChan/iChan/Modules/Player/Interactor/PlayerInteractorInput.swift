//
//  PlayerInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PlayerInteractorInput: AnyObject {
    
    /// tells interactor that play/pause button was toggled
    func togglePlayPause()
    
    /// tells interactor to seek given position in player
    /// - Parameter position: requested position
    func seekPosition(_ position: Float)
    
    /// tells interactor to assign a view to be player's drawable
    /// - Parameter drawable: view to be assigned as drawable
    func setDrawableForPlayer(_ drawable: UIView)
    
    /// tells interactor to stop player
    func stopPlayer()
}
