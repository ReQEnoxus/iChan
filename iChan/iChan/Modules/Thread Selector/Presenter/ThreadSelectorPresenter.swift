//
//  ThreadSelectorPresenter.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadSelectorPresenter: ThreadSelectorViewOutput, ThreadSelectorInteractorOutput {
    
    weak var view: ThreadSelectorViewInput!
    
    var interactor: ThreadSelectorInteractorInput!
    var dataSource: ThreadSelectorDataSource!
    var board: Board!
    
    //MARK: - ThreadSelectorViewOutput
    
    func loadMoreThreads() {
        interactor.loadMoreThreads(board: board)
    }
    
    func initialSetup() {
        
        view.setBoardName("/\(board.id)/ - \(board.name)")
        view.connectDataSource(dataSource)
    }
    
    func refreshRequested() {
        interactor.refreshThreads(board: board)
    }
    
    func didPressedCollapse(on indexPath: IndexPath) {
        view.collapseCell(at: indexPath)
    }
    
    func didSelectItem(at indexPath: IndexPath, collapsed: Bool) {
        
        if collapsed {
            view.expandCell(at: indexPath)
        }
    }
    
    //MARK: - ThreadSelectorInteractorOutput
    
    func didFinishLoadingMoreThreads(threads: [ThreadDto]) {
        
        dataSource.threads += threads
        view.refreshData()
    }
    
    func didFinishRefreshingThreads(threads: [ThreadDto]) {
        
        dataSource.threads = threads
        view.refreshData()
    }
}
