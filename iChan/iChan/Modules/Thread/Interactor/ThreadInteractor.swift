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
    
    //MARK: - ThreadInteractorInput
    func loadThread(board: String, num: String) {
        
        if let cached = cache[num] {
            presenter.didFinishLoadingThread(thread: cached, replyLoadNeeded: false)
        }
        else {
            
            service.loadThread(board: board, num: num) { [weak self] result in
                
                switch result {
                    
                    case .failure(let error):
                        self?.presenter.didFinishLoadingThread(with: error)
                    case .success(let thread):
                        self?.cache.insert(thread, forKey: thread.posts[0].num)
                        self?.presenter.didFinishLoadingThread(thread: thread, replyLoadNeeded: true)
                }
            }
        }
    }
    
    func loadNewPosts(board: String, num: String, offset: Int) {
        
        service.loadPostsFromThread(board: board, num: num, offset: offset) { [weak self] result in
            
            switch result {
                
                case .failure(let error):
                    self?.presenter.didFinishLoadingMorePosts(with: error)
                case .success(let posts):
                    
                    if let cached = self?.cache[num] {
                        cached.posts += posts
                        self?.cache.insert(cached, forKey: num)
                    }
                    
                    self?.presenter.didFinishLoadingMorePosts(posts: posts)
            }
        }
    }
    
    func didTapUrl(url: URL) {
        presenter.didFinishCheckingUrl(with: urlService.typeOf(url: url))
    }
}
