//
//  ThreadStorageServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadStorageServiceImpl: ThreadStorageService {
    
    private let crudService: CrudService = RealmCrudServiceImpl()
    
    func getAll(completion: @escaping ([Thread]) -> Void) {
        
        return crudService.get(type: ThreadModel.self, by: nil) { threads in
            
            let threadsMapped = threads.map {
                
                (model: ThreadModel) -> Thread in
                
                let posts = model.posts.map { (post) -> Post in
                    
                    return Post(comment: post.comment, name: post.name, op: post.op, num: post.num, date: post.date, files: Array(post.files).map( { File(path: $0.path, thumbnail: $0.thumbnail, displayname: $0.displayName) }))
                }
                
                let thread = Thread(filesCount: model.filesCount, posts: Array(posts), postsCount: model.postsCount)
                thread.board = model.pkey.components(separatedBy: "-")[0]
                
                return thread
            }
            
            DispatchQueue.main.async {
                completion(threadsMapped)
            }
        }
        
    }
    
    func get(board: String, num: String, completion: @escaping (Thread?) -> Void) {
                
        crudService.get(type: ThreadModel.self, by: "\(board)-\(num)") { found in
            
            guard let found = found else {
                
                DispatchQueue.main.async {
                    completion(.none)
                }
                return
            }
            
            let posts = found.posts.map { (post) -> Post in
                
                let postOut = Post(comment: post.comment, name: post.name, op: post.op, num: post.num, date: post.date, files: Array(post.files).map( { File(path: $0.path, thumbnail: $0.thumbnail, displayname: $0.displayName) }))
                postOut.repliesStr = post.repliesStr
                
                return postOut
            }
            
            let thread = Thread(filesCount: found.filesCount, posts: Array(posts), postsCount: found.postsCount)
            thread.board = found.pkey.components(separatedBy: "-")[0]
            
            DispatchQueue.main.async {
                completion(thread)
            }
        }
    }
    
    func save(_ thread: Thread) {
        crudService.save(thread)
    }
    
    func delete(thread: Thread) {
        crudService.delete(object: thread)
    }
    
    func delete(board: String, num: String) {
        
        crudService.delete(type: ThreadModel.self, predicate: NSPredicate(format: "pkey = '\(board)-\(num)'"))
    }
    
    func update(thread: Thread) {
        crudService.update(object: thread)
    }
    
    func observe(onUpdate: @escaping ([Int], [Int], [Int]) -> Void) {
        crudService.registerObserver(on: ThreadModel.self, onUpdate: onUpdate)
    }
}
