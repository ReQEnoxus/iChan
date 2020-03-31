//
//  BoardThreadsService.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardThreadsService: ApiClient {
    
    /// gets the new portion of threads from server
    /// - Parameter completion: block that is called when the data is received
    /// - Parameter board: board that the threads are requested from
    func getMoreThreads(board: String, completion: @escaping (Result<[ThreadDto], ApiError>) -> Void)
    
    /// gets first portion of threads with dropping page index
    /// - Parameter board: board that the threads are requested from
    /// - Parameter completion: block that is called when data is received
    func refreshThreads(board: String, completion: @escaping (Result<[ThreadDto], ApiError>) -> Void)
    
    /// loads all posts of given thread
    /// - Parameter board: board where thread is located
    /// - Parameter num: number of OP-post
    /// - Parameter completion: completion block that is called when data is returned
    func loadThread(board: String, num: String, completion: @escaping (Result<Thread, ApiError>) -> Void)
    
    /// loads all posts in thread after given one
    /// - Parameter board: board where thread is located
    /// - Parameter num: number of OP-post
    /// - Parameter offset: index of the first post that needs to be loaded
    /// - Parameter completion: completion block that is called when data is received
    func loadPostsFromThread(board: String, num: String, offset: Int, completion: @escaping (Result<[Post], ApiError>) -> Void) 
}
