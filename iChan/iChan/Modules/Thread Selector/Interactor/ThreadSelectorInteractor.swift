//
//  ThreadSelectorInteractor.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadSelectorInteractor: ThreadSelectorInteractorInput, CacheSubscriber {
    
    weak var presenter: ThreadSelectorInteractorOutput!
    var service: BoardThreadsService!
    var urlService: UrlCheckerService!
    var cache: Cache<String, Thread>!
    var threadStorageService: ThreadStorageService!
    var replyService: ReplyService!
    var cachedThreadsLoaded = false
    var strategyService: SavingStrategyService!
    var attachmentLoaderService: AttachmentLoaderService!
    
    func observeThreadStorage() {
        
        threadStorageService.observe { [weak self] deletions, insertions, modifications in
            
            self?.threadStorageService.getAll() { threads in
                
                self?.presenter.didReceiveUpdateNotification(new: threads.map({ $0.toDto() }),
                                                            deletions: deletions.map({ IndexPath(row: $0, section: 0) }),
                                                            insertions: insertions.map({ IndexPath(row: $0, section: 0) }),
                                                            modifications: modifications.map({ IndexPath(row: $0, section: 0) }))
            }
        }
    }
    
    //MARK: - ThreadSelectorInteractorInput
    func loadMoreThreads(board: Board?, mode: ThreadSelectorMode?) {
        
        if let mode = mode, mode == .cached {
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                
                guard let self = self else { return }
                
                if !self.cachedThreadsLoaded {
                    
                    let dtoArray = self.cache.allEntries().map({ $0.toDto() })
                    
                    DispatchQueue.main.async {
                        
                        self.cachedThreadsLoaded = true
                        self.presenter.didFinishLoadingMoreThreads(threads: dtoArray)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.presenter.didFinishLoadingMoreWith(error: .jsonParsingFailure)
                    }
                }
            }
        }
        else if let mode = mode, mode == .realm {
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                
                guard let self = self else { return }
                
                if !self.cachedThreadsLoaded {
                    
                    self.threadStorageService.getAll() { threads in
                        
                        let mapped = threads.map( { $0.toDto() })
                        
                        DispatchQueue.main.async {
                            
                            self.cachedThreadsLoaded = true
                            self.presenter.didFinishLoadingMoreThreads(threads: mapped)
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.presenter.didFinishLoadingMoreWith(error: .jsonParsingFailure)
                    }
                }
            }
        }
        else if let board = board {
            
            service.getMoreThreads(board: board.id) { [weak self] result in
                
                switch result {
                    
                case .failure(let error):
                    self?.presenter.didFinishLoadingMoreWith(error: error)
                case .success(let threads):
                    self?.presenter.didFinishLoadingMoreThreads(threads: threads)
                }
            }
        }
    }
    
    func deleteThread(board: String, num: String) {
        threadStorageService.delete(board: board, num: num)
    }
    
    func refreshThreads(board: Board?, mode: ThreadSelectorMode?) {
        
        if let mode = mode, mode == .cached {
            
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                
                guard let self = self else { return }
                
                let dtoArray = self.cache.allEntries().map({ $0.toDto() })
                DispatchQueue.main.async {
                    
                    self.cachedThreadsLoaded = true
                    self.presenter.didFinishRefreshingThreads(threads: dtoArray)
                }
            }
        }
        else if let mode = mode, mode == .realm {
            
            threadStorageService.getAll() { threads in
                
                let dtoArray = threads.map({ $0.toDto() })
                
                self.cachedThreadsLoaded = true
                self.presenter.didFinishRefreshingThreads(threads: dtoArray)
            }
        }
        else if let board = board {
            
            service.refreshThreads(board: board.id) { [weak self] result in
                
                switch result {
                    
                case .failure(let error):
                    self?.presenter.didFinishRefreshingWith(error: error)
                case .success(let threads):
                    self?.presenter.didFinishRefreshingThreads(threads: threads)
                }
            }
        }
    }
    
    func saveThread(board: String, num: String) {
        
        let strategy = strategyService.getCurrentStrategy()
        
        presenter.didStartLoading(with: strategy)
            
        service.loadThread(board: board, num: num) { [weak self] result in
            
            switch result {
                
            case .success(let thread):
                
                self?.replyService.generateReplies(for: thread.posts) { posts in
                    
                    self?.attachmentLoaderService.loadAttachments(strategy: strategy, posts: posts, onFileLoaded: { progress in
                        
                        self?.presenter.didProgressAtLoading(progress)
                    }, completion: { posts, successful in
                        
                        if successful {
                            
                            thread.posts = posts
                            self?.threadStorageService.update(thread: thread)
                        }
                        self?.presenter.didFinishSavingThread()
                    })
                }
            case .failure(let error):
                
                print(error)
                self?.presenter.didFinishSavingThread()
            }
        }
    }
    
    func didTapUrl(url: URL) {
        presenter.didFinishCheckingUrl(with: urlService.typeOf(url: url))
    }
    
    func interruptCurrentDownload() {
        attachmentLoaderService.interruptCurrentLoading()
    }
    
    //MARK: - Cache Subscriber
    func cacheDidUpdate() {
        refreshThreads(board: nil, mode: .cached)
    }
}
