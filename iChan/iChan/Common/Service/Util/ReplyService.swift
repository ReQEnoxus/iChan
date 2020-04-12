//
//  ReplyService.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ReplyService: AnyObject {
    
    /// generates replies for given array of posts assuming no replies are generated yet
    /// - Parameter posts: posts array
    /// - Parameter completion: block that is called when replies are generated
    func generateReplies(for posts: [Post], completion: @escaping ([Post]) -> Void)
    
    /// updates replies based on appended posts array
    /// - Parameter initial: initial posts array in which replies are already generated
    /// - Parameter appended: appended posts array
    /// - Parameter completion: block that is called when replies are updated
    func updateReplies(initial: [Post], appended: [Post], completion: @escaping ([Post]) -> Void)
    
    /// generates replies for given array of posts assuming no replies are generated yet, also manages indices
    /// - Parameter posts: posts array
    /// - Parameter completion: block that is called when replies are generated
    func generateRepliesWithIndices(for posts: [Post], completion: @escaping ([Post], [IndexPath], [IndexPath]) -> Void)
    
    /// updates replies based on appended posts array, also manages indices
    /// - Parameter initial: initial posts array in which replies are already generated
    /// - Parameter appended: appended posts array
    /// - Parameter completion: block that is called when replies are updated
    func updateRepliesWithIndices(initial: [Post], appended: [Post], completion: @escaping ([Post], [IndexPath], [IndexPath]) -> Void)
}
