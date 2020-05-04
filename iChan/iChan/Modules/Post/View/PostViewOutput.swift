//
//  PostViewOutput.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostViewOutput: AnyObject {
    
    /// tells presenter that image was tapped
    /// - Parameter index: index of tapped image
    /// - Parameter files: image array
    func didTapImage(index: Int, files: [File])
    
    /// tells presenter that url inside of textview was tapped
    /// - Parameter url: tapped url
    func didTapUrl(url: URL)
    
    /// asks presenter to perform initial setup
    func initialSetup()
    
    /// tells presenter that user has requested dismissal for this module
    func dismissRequested()
    
    /// tells presenter that user pressed on the number of particular post
    /// - Parameter replyingTo: number of post which user has pressed
    func postNumberButtonPressed(replyingTo: String)
}
