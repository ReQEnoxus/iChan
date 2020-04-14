//
//  ThreadInteractor.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadInteractor: ThreadInteractorInput {
    
    weak var presenter: ThreadInteractorOutput!
    var service: BoardThreadsService!
    var urlService: UrlCheckerService!
    var cache: Cache<String, Thread>!
    var replyService: ReplyService!
    var threadStorageService: ThreadStorageService!
    
    //MARK: - ThreadInteractorInput
    func loadThread(board: String, num: String) {
        
        threadStorageService.get(board: board, num: num) { [weak self] stored in
            
            guard let stored = stored else {
                
                if let cached = self?.cache[num] {
                    self?.presenter.didFinishLoadingThread(thread: cached, replyLoadNeeded: false, idxToInsert: [], idxToUpdate: [])
                }
                else {
                    
                    self?.service.loadThread(board: board, num: num) { [weak self] result in
                        
                        switch result {
                            
                            case .failure(let error):
                                print("error loading from net")
                                self?.presenter.didFinishLoadingThread(with: error)
                            case .success(let thread):
                                
                                self?.replyService.generateRepliesWithIndices(for: thread.posts) { posts, idxToInsert, idxToUpdate in
                                    
                                    thread.posts = posts
                                    self?.cache.insert(thread, forKey: thread.posts[0].num)
                                    self?.presenter.didFinishLoadingThread(thread: thread, replyLoadNeeded: true, idxToInsert: idxToInsert, idxToUpdate: idxToUpdate)
                                }
                        }
                    }
                }
                
                return
            }
            
            self?.cache.insert(stored, forKey: stored.posts[0].num)
            self?.presenter.didFinishLoadingThread(thread: stored, replyLoadNeeded: false, idxToInsert: [], idxToUpdate: [])
        }
    }
    
    func loadNewPosts(initial: [Post], board: String, num: String, offset: Int) {
        
        service.loadPostsFromThread(board: board, num: num, offset: offset) { [weak self] result in
            
            switch result {
                
                case .failure(let error):
                    self?.presenter.didFinishLoadingMorePosts(with: error)
                case .success(let posts):
                    
                    self?.replyService.updateRepliesWithIndices(initial: initial, appended: posts) { updatedPosts, idxToInsert, idxToUpdate in
                        
                        if let cached = self?.cache[num] {
                            
                            cached.posts = updatedPosts
                            self?.cache.insert(cached, forKey: num)
                        }
                        
                        self?.presenter.didFinishLoadingMorePosts(posts: updatedPosts, idxToInsert: idxToInsert, idxToUpdate: idxToUpdate)
                        
                        self?.threadStorageService.get(board: board, num: num, completion: { thread in
                            
                            if let thread = thread {
                                
                                thread.posts = updatedPosts
                                self?.threadStorageService.update(thread: thread)
                            }
                        })
                    }
            }
        }
    }
    
    func didTapUrl(url: URL) {
        presenter.didFinishCheckingUrl(with: urlService.typeOf(url: url))
    }
}
