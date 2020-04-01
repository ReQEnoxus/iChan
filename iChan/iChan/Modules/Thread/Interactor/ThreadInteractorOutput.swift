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
    func didFinishLoadingThread(thread: Thread)
    
    /// tells presenter that loading the thread has finished with error
    /// - Parameter error: error that occured during fetch
    func didFinishLoadingThread(with error: ApiError)
    
    /// tells presenter that updated posts are loaded
    /// - Parameter posts: fetched posts
    func didFinishLoadingMorePosts(posts: [Post])
    
    /// tells presenter that loading more posts has finished with error
    /// - Parameter error: error that occured during fetch
    func didFinishLoadingMorePosts(with error: ApiError)
    
    func didFinishCheckingUrl(with type: UrlType)
}
