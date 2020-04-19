//
//  PlayerViewInput.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PlayerViewInput: AnyObject {
    
    var playerView: UIView { get }
        
    func setValueForSlider(_ value: Float)
    
    func setValueForTimeLabel(_ value: String)
    
    func initialSetupFinished()
}
