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
    
    //MARK: - ThreadSelectorInteractorInput
    func loadMoreThreads(board: Board) {
        
        service.getMoreThreads(board: board.id) { [weak self] result in
            
            switch result {
                
            case .failure(let error):
                self?.presenter.didFinishLoadingMoreWith(error: error)
            case .success(let threads):
                self?.presenter.didFinishLoadingMoreThreads(threads: threads)
            }
        }
    }
    
    func refreshThreads(board: Board) {
        
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
