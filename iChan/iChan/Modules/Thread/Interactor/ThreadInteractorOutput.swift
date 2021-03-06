//
//  ThreadInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadInteractorOutput: AnyObject {
    
    /// tells presenter that thread is loaded
    /// - Parameter thread: thread that has been loaded
    /// - Parameter replyLoadNeeded: decides if datasource should recalculate replies
    func didFinishLoadingThread(thread: Thread, replyLoadNeeded: Bool, idxToInsert: [IndexPath], idxToUpdate: [IndexPath])
    
    /// tells presenter that loading the thread has finished with error
    /// - Parameter error: error that occured during fetch
    func didFinishLoadingThread(with error: ApiError)
    
    /// tells presenter that updated posts are loaded
    /// - Parameter posts: fetched posts
    func didFinishLoadingMorePosts(posts: [Post], idxToInsert: [IndexPath], idxToUpdate: [IndexPath])
    
    /// tells presenter that loading more posts has finished with error
    /// - Parameter error: error that occured during fetch
    func didFinishLoadingMorePosts(with error: ApiError)
    
    /// tells presenter that url was checked and has certain type
    /// - Parameter type: type of the url
    func didFinishCheckingUrl(with type: UrlType)
}
