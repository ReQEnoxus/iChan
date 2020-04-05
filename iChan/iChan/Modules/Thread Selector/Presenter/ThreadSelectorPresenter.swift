//
//  ThreadSelectorPresenter.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadSelectorPresenter: ThreadSelectorViewOutput, ThreadSelectorInteractorOutput, ThreadSelectorDataSourceOutput {
    
    weak var view: ThreadSelectorViewInput!
    
    var interactor: ThreadSelectorInteractorInput!
    var dataSource: ThreadSelectorDataSource!
    var router: ThreadSelectorRouterInput!
    var board: Board!
    
    //MARK: - ThreadSelectorViewOutput
    
    func loadMoreThreads() {
        interactor.loadMoreThreads(board: board)
    }
    
    func initialSetup() {
        
        view.displayLoadingView()
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
        else {
            
            let board = self.board.id
            let num = dataSource.threads[indexPath.row].number
            
            router.pushThreadController(board: board, num: num)
        }
    }
    
    //MARK: - ThreadSelectorInteractorOutput
    
    func didFinishLoadingMoreThreads(threads: [ThreadDto]) {
        
        dataSource.appendThreads(threads) { [weak self] insertedIndices in
            
            self?.view.refreshData(indicesToRefresh: insertedIndices)
        }
    }
    
    func didFinishLoadingMoreWith(error: ApiError) {
        
        switch error {
            
        case .jsonParsingFailure:
            view.stopLoadingIndicator()
        default:
            print(error.localizedDescription)
        }
    }
    
    func didFinishRefreshingWith(error: ApiError) {
        view.displayErrorView()
    }
    
    func didFinishRefreshingThreads(threads: [ThreadDto]) {
        
        view.displayTableView()
        dataSource.threads = threads
        view.refreshData()
    }
    
    func didFinishCheckingUrl(with type: UrlType) {
        
        switch type {
            
            case .inner(let board, let num), .innerReply(let board, let num, _):
                router.pushThreadController(board: board, num: num)
            case .outer(let url):
                router.open(url: url)
        }
    }
    
    //MARK: - ThreadSelectorDataSourceOutput
    func didTapImage(with attachment: AttachmentDto) {
        router.presentImage(with: attachment)
    }
    
    func didTapTextView(at indexPath: IndexPath) {
        
        let board = self.board.id
        let num = dataSource.threads[indexPath.row].number
        
        router.pushThreadController(board: board, num: num)
    }
    
    func didTapUrl(url: URL) {
        interactor.didTapUrl(url: url)
    }
}
