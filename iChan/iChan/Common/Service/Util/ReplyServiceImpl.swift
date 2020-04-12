//
//  ReplyServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyServiceImpl: ReplyService {
    
    func generateReplies(for posts: [Post], completion: @escaping ([Post]) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            var idxToUpdate = Set<IndexPath>()
            
            for i in 0 ..< posts.count {
                
                if posts[i].comment.contains("class=\"post-reply-link\"") {
                    
                    let matches = posts[i].comment.matches(for: ">>[0-9]+")
                    
                    for match in matches {
                        
                        let matchNum = match.replacingOccurrences(of: ">>", with: String())
                        
                        for j in 0 ..< posts.count {
                            
                            if posts[j].num == matchNum {
                                
                                if !posts[j].replies.contains(posts[i].num) {
                                    
                                    posts[j].replies.append(posts[i].num)
                                    idxToUpdate.insert(IndexPath(row: j, section: 0))
                                }
                            }
                        }
                    }
                }
            }
            
            idxToUpdate.forEach({ posts[$0.row].generateRepliesString() })
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
    }
    
    func updateReplies(initial: [Post], appended: [Post], completion: @escaping ([Post]) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let joined = initial + appended
            var idxToUpdate = Set<IndexPath>()
            
            for i in 0 ..< appended.count {
                
                if appended[i].comment.contains("class=\"post-reply-link\"") {
                    
                    let matches = appended[i].comment.matches(for: ">>[0-9]+")
                    
                    for match in matches {
                        
                        let matchNum = match.replacingOccurrences(of: ">>", with: String())
                        
                        for j in 0 ..< joined.count {
                            
                            if joined[j].num == matchNum {
                                
                                if !joined[j].replies.contains(appended[i].num) {
                                    
                                    joined[j].replies.append(appended[i].num)
                                    idxToUpdate.insert(IndexPath(row: j, section: 0))
                                }
                            }
                        }
                    }
                }
            }
            
            idxToUpdate.forEach({ joined[$0.row].generateRepliesString() })
            
            DispatchQueue.main.async {
                completion(joined)
            }
        }
    }
    
    func generateRepliesWithIndices(for posts: [Post], completion: @escaping ([Post], [IndexPath], [IndexPath]) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            var idxToUpdate = Set<IndexPath>()
            var idxToInsert = [IndexPath]()

            for i in 0 ..< posts.count {
                
                if posts[i].comment.contains("class=\"post-reply-link\"") {
                    
                    let matches = posts[i].comment.matches(for: ">>[0-9]+")
                    
                    for match in matches {
                        
                        let matchNum = match.replacingOccurrences(of: ">>", with: String())
                        
                        for j in 0 ..< posts.count {
                            
                            if posts[j].num == matchNum {
                                
                                if !posts[j].replies.contains(posts[i].num) {
                                    
                                    posts[j].replies.append(posts[i].num)
                                    idxToUpdate.insert(IndexPath(row: j, section: 0))
                                }
                            }
                        }
                    }
                }
            }
            
            idxToUpdate.forEach({ posts[$0.row].generateRepliesString() })
            
            for i in 0 ..< posts.count {
                idxToInsert.append(IndexPath(row: i, section: 0))
            }
            
            DispatchQueue.main.async {
                completion(posts, idxToInsert, Array(idxToUpdate))
            }
        }
    }
    
    func updateRepliesWithIndices(initial: [Post], appended: [Post], completion: @escaping ([Post], [IndexPath], [IndexPath]) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let joined = initial + appended
            var idxToInsert = [IndexPath]()
            var idxToUpdate = Set<IndexPath>()
            let initialCount = initial.count
            
            for i in 0 ..< appended.count {
                
                if appended[i].comment.contains("class=\"post-reply-link\"") {
                    
                    let matches = appended[i].comment.matches(for: ">>[0-9]+")
                    
                    for match in matches {
                        
                        let matchNum = match.replacingOccurrences(of: ">>", with: String())
                        
                        for j in 0 ..< joined.count {
                            
                            if joined[j].num == matchNum {
                                
                                if !joined[j].replies.contains(appended[i].num) {
                                    
                                    joined[j].replies.append(appended[i].num)
                                    idxToUpdate.insert(IndexPath(row: j, section: 0))
                                }
                            }
                        }
                    }
                }
            }
            
            idxToUpdate.forEach({ joined[$0.row].generateRepliesString() })
            
            for i in 0 ..< appended.count {
                idxToInsert.append(IndexPath(row: initialCount + i, section: 0))
            }
            
            DispatchQueue.main.async {
                completion(joined, idxToInsert, Array(idxToUpdate))
            }
        }
    }
}
