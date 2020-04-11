//
//  ThreadSelectorInteractor.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadSelectorInteractor: ThreadSelectorInteractorInput {
    
    weak var presenter: ThreadSelectorInteractorOutput!
    var service: BoardThreadsService!
    var urlService: UrlCheckerService!
    var cache: Cache<String, Thread>!
    var cachedThreadsLoaded = false
    
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
    
    func didTapUrl(url: URL) {
        presenter.didFinishCheckingUrl(with: urlService.typeOf(url: url))
    }
}
