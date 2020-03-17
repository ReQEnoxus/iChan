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
    
    func loadMoreThreads(board: Board) {
        
        service.getMoreThreads(board: board.id) { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let threads):
                self?.presenter.didFinishLoadingMoreThreads(threads: threads)
            }
        }
    }
}
