//
//  PlayerViewOutput.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PlayerViewOutput: AnyObject {
    
    func playOrPauseToggled()
    
    func sliderDidChangeValue(newValue: Float)
    
    func exitButtonPressed()
    
    func initialSetup()
}
