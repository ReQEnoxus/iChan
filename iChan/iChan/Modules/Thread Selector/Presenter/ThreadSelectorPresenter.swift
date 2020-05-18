//
//  ThreadSelectorPresenter.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadSelectorPresenter: ThreadSelectorViewOutput, ThreadSelectorInteractorOutput, ThreadSelectorDataSourceOutput, ThreadSelectorRouterOutput {
    
    weak var view: ThreadSelectorViewInput!
    
    var interactor: ThreadSelectorInteractorInput!
    var dataSource: ThreadSelectorDataSource!
    var router: ThreadSelectorRouterInput!
    var board: Board?
    var title: String?
    var mode: ThreadSelectorMode?
    
    //MARK: - ThreadSelectorViewOutput
    func loadMoreThreads() {
        interactor.loadMoreThreads(board: board, mode: mode)
    }
    
    func initialSetup() {
        
        view.displayLoadingView()
        
        if mode == .none {
            view.configureCreateThreadButton()
        }
        
        if let title = title, mode != nil {
            
            view.setBoardName(title)
            view.disablePullToRefresh()
            
            if mode! == .realm {
                view.configureHistoryContextualActions()
            }
        }
        else if let board = board {
            view.setBoardName("/\(board.id)/ - \(board.name)")
        }
        view.connectDataSource(dataSource)
    }
    
    func refreshRequested() {
        interactor.refreshThreads(board: board, mode: mode)
    }
    
    func refreshInErrorState() {
        
        view.displayLoadingView()
        interactor.refreshThreads(board: board, mode: mode)
    }
    
    func didPressedCollapse(on indexPath: IndexPath) {
        view.collapseCell(at: indexPath)
    }
    
    func didPressedCreateThread() {
        
        guard let board = board?.id else { return }
        router.presentReplyController(board: board, threadNum: String(Int.zero), replyingTo: .none)
    }
    
    func didPressedSave(on indexPath: IndexPath) {
        
        let board = dataSource.threads[indexPath.row].board
        let num = dataSource.threads[indexPath.row].number
        
        interactor.saveThread(board: board, num: num)
    }
    
    func didPressedDelete(on indexPath: IndexPath) {
        
        let board = dataSource.threads[indexPath.row].board
        let num = dataSource.threads[indexPath.row].number
        
        interactor.deleteThread(board: board, num: num)
    }
    
    
    func didSelectItem(at indexPath: IndexPath, collapsed: Bool) {
        
        if collapsed {
            view.expandCell(at: indexPath)
        }
        else {
            let board = dataSource.threads[indexPath.row].board
            let num = dataSource.threads[indexPath.row].number
            
            router.pushThreadController(board: board, num: num, postNum: nil)
        }
    }
    
    func didRequestInterruption() {
        
        view.hideLoadingHud()
        interactor.interruptCurrentDownload()
    }
    
    //MARK: - ThreadSelectorInteractorOutput
    func didFinishLoadingMoreThreads(threads: [ThreadDto]) {
        
        dataSource.appendThreads(threads) { [weak self] insertedIndices in
            
            self?.view.refreshData(indicesToRefresh: insertedIndices)
        }
    }
    
    func didReceiveUpdateNotification(new: [ThreadDto], deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath]) {
        
        dataSource.threads = new
        
        if !dataSource.threads.isEmpty {
            view.displayTableView()
        }
        
        if view.isVisible {
            
            view.refreshData(deletions: deletions, insertions: insertions, modifications: modifications)
        }
        else {
        
            view.refreshData()
        }
        
        if dataSource.threads.isEmpty {
            view.displayErrorView(style: .history)
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
        
        if let mode = mode {
            
            if mode == .cached {
                view.displayErrorView(style: .cache)
            }
            else if mode == .realm {
                view.displayErrorView(style: .history)
            }
        }
        else {
            view.displayErrorView(style: .network)
        }
    }
    
    func didFinishRefreshingThreads(threads: [ThreadDto]) {

        if threads.isEmpty {
            
            if let mode = mode {
                
                if mode == .cached {
                    view.displayErrorView(style: .cache)
                }
                else if mode == .realm {
                    view.displayErrorView(style: .history)
                }
            }
            else {
                view.displayErrorView(style: .network)
            }
        }
        else {
            
            view.displayTableView()
            dataSource.threads = threads
            view.refreshData()
        }
    }
    
    func didFinishSavingThread() {
        view.hideLoadingHud()
    }
    
    func didProgressAtLoading(_ progress: Double) {
        view.updateDownloadingProgress(percentage: progress)
    }
    
    func didFinishCheckingUrl(with type: UrlType) {
        
        switch type {
            
            case .inner(let board, let opNum, postNum: let postNum):
                router.pushThreadController(board: board, num: opNum, postNum: postNum)
            case .outer(let url):
                router.open(url: url)
            case .innerReply:
                // impossible case
                break
        }
    }
    
    func didStartLoading(with strategy: SavingStrategy) {
        
        switch strategy {
            
            case .textOnly:
                view.displayLoadingHud(determined: false)
            default:
                view.displayLoadingHud(determined: true)
        }
    }
    
    //MARK: - ThreadSelectorDataSourceOutput
    func didTapImage(with attachment: AttachmentDto) {
        router.presentImage(with: attachment)
    }
    
    func didTapTextView(at indexPath: IndexPath) {
        
        let board = dataSource.threads[indexPath.row].board
        let num = dataSource.threads[indexPath.row].number
        
        router.pushThreadController(board: board, num: num, postNum: nil)
    }
    
    func didTapUrl(url: URL) {
        interactor.didTapUrl(url: url)
    }
    
    //MARK: - Router Output
    func createdThread(with num: Int) {
        
        if let board = board?.id {
            router.pushThreadController(board: board, num: String(num), postNum: .none)
        }
    }
}
