//
//  ThreadViewInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadInteractorInput: AnyObject {
    
    /// tells interactor to load a thread
    /// - Parameter board: board where thread is located
    /// - Parameter num: number of OP-post
    func loadThread(board: String, num: String)
    
    /// tells interactor to load new posts for a given thread
    /// - Parameter board: board where thread is located
    /// - Parameter num: number of OP-post
    /// - Parameter offset: number of the first post to be fetched
    func loadNewPosts(board: String, num: String, offset: Int)
}
