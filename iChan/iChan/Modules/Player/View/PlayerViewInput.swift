//
//  PlayerViewInput.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PlayerViewInput: AnyObject {
    
    /// view that will be used as drawable for player
    var playerView: UIView { get }
    
    /// sets specific value to the slider
    /// - Parameter value: value to be set
    func setValueForSlider(_ value: Float)
    
    /// sets specific value to the time label
    /// - Parameter value: value to be set
    func setValueForTimeLabel(_ value: String)
    
    /// tells view that setup was performed and playerview was assigned as drawable
    func initialSetupFinished()
    
    /// tells view to display loading indicator
    func displayLoadingIndicator()
    
    /// tells view to remove loading indicator
    func removeLoadingIndicator()
}
