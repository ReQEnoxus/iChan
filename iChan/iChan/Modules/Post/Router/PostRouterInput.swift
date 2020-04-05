//
//  PostRouterInput.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol PostRouterInput: AnyObject {
    
    /// tells router to present given images starting at given index
    /// - Parameter index: index to start from
    /// - Parameter files: images to present
    func presentImage(index: Int, files: [File])
    
    /// tells router to dismiss currently open post module
    func dismissPostModule()
    
    /// tells presenter to dismiss currently open module and navigate to another thread
    /// - Parameter board: board where target thread is located
    /// - Parameter opNum: number of target OP-post
    /// - Parameter postNum: optional number of the post in another thread that needs to be immediately presented
    func dismissPostModuleAndPushThread(board: String, opNum: String, postNum: String?)
    
    /// tells router to open an external link in safari controller
    /// - Parameter url: url to be opened
    func open(url: URL)
}
