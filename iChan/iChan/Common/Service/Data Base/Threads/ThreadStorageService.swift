//
//  ThreadStorageService.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadStorageService: AnyObject {
    
    /// gets all threads from realm storage
    /// - Parameter completion: block that is called when data is retrieved
    func getAll(completion: @escaping ([Thread]) -> Void)
    
    /// gets specific thread from realm storage
    /// - Parameter board: board
    /// - Parameter num: OP-number
    /// - Parameter completion: block that is called when data is retrieved
    func get(board: String, num: String, completion: @escaping (Thread?) -> Void)
    
    /// saves thread into realm
    /// - Parameter thread: thread to save
    func save(_ thread: Thread)
    
    /// deletes the thread from realm
    /// - Parameter thread: thread to delete
    func delete(thread: Thread)
    
    /// deletes the thread identified on board and op number
    /// - Parameter board: board
    /// - Parameter num: OP-number
    func delete(board: String, num: String)
    
    /// updates existing thread or creates a new one if it doesn't exist
    /// - Parameter thread: updated instance
    func update(thread: Thread)
    
    /// registers an observer to the persistent storage
    /// - Parameter onUpdate: block that is called everytime persistent storage updates
    func observe(onUpdate: @escaping ([Int], [Int], [Int]) -> Void)
}
