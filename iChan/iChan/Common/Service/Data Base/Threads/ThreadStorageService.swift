//
//  ThreadStorageService.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadStorageService: AnyObject {
    
    func getAll(completion: @escaping ([Thread]) -> Void)
    
    func get(board: String, num: String, completion: @escaping (Thread?) -> Void)
    
    func save(_ thread: Thread)
    
    func delete(thread: Thread)
    
    func delete(board: String, num: String)
    
    func update(thread: Thread)
    
    func observe(onUpdate: @escaping ([Int], [Int], [Int]) -> Void)
}
