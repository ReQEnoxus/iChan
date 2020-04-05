//
//  ThreadSelectorRouterInput.swift
//  iChan
//
//  Created by Enoxus on 29/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorRouterInput: AnyObject {
    
    /// tells router to present image with given url
    /// - Parameter attachment: attachment to be displayed fullscrren
    func presentImage(with attachment: AttachmentDto)
    
    /// tells router to push another thread controller on top of current one
    /// - Parameter board: board where target thread is located
    /// - Parameter num: number of the OP-post of the target thread
    /// - Parameter postNum: optional number of the post that needs to be immediately displayed
    func pushThreadController(board: String, num: String, postNum: String?)
    
    /// tells router to open an external url in safari controller
    /// - Parameter url: url to be opened
    func open(url: URL)
}
