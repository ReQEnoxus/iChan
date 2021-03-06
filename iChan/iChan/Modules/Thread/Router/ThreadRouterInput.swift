//
//  ThreadViewRouterInput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadRouterInput: AnyObject {
    
    /// tells router to present image
    /// - Parameter index: index of image in collectionview
    /// - Parameter files: attachments of the post
    func presentImage(index: Int, files: [File])
    
    /// tells router to open an external url in safari controller
    /// - Parameter url: url to be opened
    func open(url: URL)
    
    /// tells router to present post module
    /// - Parameter posts: all posts in this thread
    /// - Parameter postNum: requested post
    /// - Parameter board: board on which post is being opened
    func presentPostController(posts: [Post], board: String, postNum: String)
    
    /// tells router to push another thread
    /// - Parameter board: board where target thread is located
    /// - Parameter opNum: number of the OP-post of the target thread
    /// - Parameter postNum: optional number of the post that needs to be displayed immediately
    func pushAnotherThread(board: String, opNum: String, postNum: String?)
    
    /// tells router to present reply controller
    /// - Parameters:
    ///   - board: board where new post should appear
    ///   - threadNum: OP-post of the thread where post should appear
    ///   - replyingTo: number of post which new post is replying to
    func presentReplyController(board: String, threadNum: String, replyingTo: String?)
}
