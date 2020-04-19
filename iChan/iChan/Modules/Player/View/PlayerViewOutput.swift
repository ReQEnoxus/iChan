//
//  PlayerViewOutput.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PlayerViewOutput: AnyObject {
    
    /// tells presenter that user has toggled play/pause control
    func playOrPauseToggled()
    
    /// tells presenter that user has changed slider value
    /// - Parameter newValue: new value of the slider
    func sliderDidChangeValue(newValue: Float)
    
    /// tells presenter that exit button was pressed
    func exitButtonPressed()
    
    /// tells presenter to perform initial setup
    func initialSetup()
}
