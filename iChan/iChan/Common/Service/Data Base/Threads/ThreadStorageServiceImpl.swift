//
//  ThreadStorageServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadStorageServiceImpl: ThreadStorageService {
    
    /// crud service for realm accessing
    var crudService: CrudService!
    /// file manager that accesses device file system
    var fileManager: FileManagingService!
    
    func getAll(completion: @escaping ([Thread]) -> Void) {
        
        return crudService.get(type: ThreadModel.self, order: Order(keyPath: #keyPath(ThreadModel.createdAt), ascending: false), by: nil) { [weak self] threads in
            
            let threadsMapped = threads.map {
                
                (model: ThreadModel) -> Thread in
                
                let posts = model.posts.map { (post) -> Post in
                    
                    let postToReturn = Post(comment: post.comment, name: post.name, op: post.op, num: post.num, date: post.date, files: Array(post.files).map( { File(path: Endpoint.baseUrl + $0.path, thumbnail: $0.thumbnail, displayname: $0.displayName) }))
                    
                    postToReturn.repliesStr = post.repliesStr
                    
                    if postToReturn.files != nil {
                        
                        for i in .zero ..< postToReturn.files!.count {
                            
                            postToReturn.files![i].localThumbnailUrl = post.files[i].thumbnailDataUrl
                            postToReturn.files![i].thumbnailData = self?.fileManager.get(by: postToReturn.files![i].localThumbnailUrl ?? String())
                            
                            postToReturn.files![i].localFileUrl = post.files[i].fileDataUrl
                            postToReturn.files![i].fileData = self?.fileManager.get(by: postToReturn.files![i].localFileUrl ?? String())
                            
                            
                        }
                    }
                    
                    return postToReturn
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
                
        crudService.get(type: ThreadModel.self, by: "\(board)-\(num)") { [weak self] found in
            
            guard let found = found else {
                
                DispatchQueue.main.async {
                    completion(.none)
                }
                return
            }
            
            let posts = found.posts.map { (post) -> Post in
                
                let postToReturn = Post(comment: post.comment, name: post.name, op: post.op, num: post.num, date: post.date, files: Array(post.files).map( { File(path: Endpoint.baseUrl + $0.path, thumbnail: $0.thumbnail, displayname: $0.displayName) }))
                
                postToReturn.repliesStr = post.repliesStr
                
                if postToReturn.files != nil {
                    
                    for i in .zero ..< postToReturn.files!.count {
                        
                        postToReturn.files![i].localThumbnailUrl = post.files[i].thumbnailDataUrl
                        postToReturn.files![i].thumbnailData = self?.fileManager.get(by: postToReturn.files![i].localThumbnailUrl ?? String())
                        
                        postToReturn.files![i].localFileUrl = post.files[i].fileDataUrl
                        postToReturn.files![i].fileData = self?.fileManager.get(by: postToReturn.files![i].localFileUrl ?? String())
                        
                        
                    }
                }
                
                return postToReturn
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
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            for post in thread.posts {
                
                for file in post.files ?? [] {
                    
                    self?.fileManager.delete(from: file.localThumbnailUrl)
                    self?.fileManager.delete(from: file.localFileUrl)
                }
            }
            
            DispatchQueue.main.async {
                self?.crudService.delete(object: thread)
            }
        }
    }
    
    func delete(board: String, num: String) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            self?.get(board: board, num: num, completion: { (thread) in
                
                guard let thread = thread else { return }
                
                for post in thread.posts {
                    
                    for file in post.files ?? [] {
                        
                        self?.fileManager.delete(from: file.localThumbnailUrl)
                        self?.fileManager.delete(from: file.localFileUrl)
                    }
                }
                
                DispatchQueue.main.async {
                    self?.crudService.delete(type: ThreadModel.self, predicate: NSPredicate(format: "pkey = '\(board)-\(num)'"))
                }
            })
        }
    }
    
    func update(thread: Thread) {
        crudService.update(object: thread)
    }
    
    func observe(onUpdate: @escaping ([Int], [Int], [Int]) -> Void) {
        crudService.registerObserver(on: ThreadModel.self, order: Order(keyPath: #keyPath(ThreadModel.createdAt), ascending: false), onUpdate: onUpdate)
    }
}
