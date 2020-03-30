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
    
    func loadThread(board: String, num: String) {
        
        service.loadThread(board: board, num: num) { [weak self] result in
            
            switch result {
                
                case .failure(let error):
                    self?.presenter.didFinishLoadingThread(with: error)
                case .success(let thread):
                    self?.presenter.didFinishLoadingThread(thread: thread)
            }
        }
    }
}
