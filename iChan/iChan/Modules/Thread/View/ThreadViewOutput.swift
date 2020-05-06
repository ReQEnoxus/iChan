//
//  ThreadViewOutput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadViewOutput {
    
    /// tells presenter to perform initial setup
    func initialSetup()
    
    /// tells presenter to load thread from scratch
    func loadThread()
    
    /// tells presenter that user has requested refresh in error state
    func refreshInErrorState()
    
    /// tells presenter to update thread with new posts
    func update()
    
    /// tells preenter that user has tapped reply button
    func didPressReplyButton()
}
