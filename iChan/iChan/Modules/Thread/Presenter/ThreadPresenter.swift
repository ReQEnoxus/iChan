//
//  ThreadPresenter.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadPresenter: ThreadViewOutput, ThreadInteractorOutput, ThreadDataSourceOutput, ThreadRouterOutput {
    
    weak var view: ThreadViewInput!
    var interactor: ThreadInteractorInput!
    var router: ThreadRouterInput!
    var dataSource: ThreadDataSource!
    
    var board: String!
    var num: String!
    var postNum: String?
    
    private var needsToBeScrolledToBottom = false
    
    //MARK: - View Output
    func initialSetup() {
        
        view.displayLoadingView()
        view.connectDataSource(dataSource)
    }
    
    func loadThread() {
        interactor.loadThread(board: board, num: num)
    }
    
    func update() {
        interactor.loadNewPosts(initial: dataSource.posts, board: board, num: num, offset: dataSource.posts.count + 1)
    }
    
    func refreshInErrorState() {
        
        view.displayLoadingView()
        interactor.loadThread(board: board, num: num)
    }
    
    func didPressReplyButton() {
        router.presentReplyController(board: board, threadNum: num, replyingTo: .none)
    }
    
    //MARK: - Interactor Output
    func didFinishLoadingThread(thread: Thread, replyLoadNeeded: Bool, idxToInsert: [IndexPath], idxToUpdate: [IndexPath]) {
        
        if replyLoadNeeded {
            
            dataSource.posts = thread.posts
            view.refreshData(indicesToInsert: idxToInsert, indicesToUpdate: idxToUpdate, animated: false)
            view.displayTableView()
            if let requestedPostNum = postNum {
                router.presentPostController(posts: thread.posts, board: thread.board, postNum: requestedPostNum)
            }
        }
        else {
            
            dataSource.posts = thread.posts
            view.refreshData()
            view.displayTableView()
        }
    }
    
    func didFinishLoadingThread(with error: ApiError) {
        
        print(error.localizedDescription)
        view.displayErrorView()
    }
    
    func didFinishLoadingMorePosts(posts: [Post], idxToInsert: [IndexPath], idxToUpdate: [IndexPath]) {
        
        dataSource.posts = posts
        view.refreshData(indicesToInsert: idxToInsert, indicesToUpdate: idxToUpdate, animated: true)
        
        if needsToBeScrolledToBottom {
            
            view.scrollToRow(at: IndexPath(row: posts.count - 1, section: .zero))
            needsToBeScrolledToBottom.toggle()
        }
    }
    
    func didFinishLoadingMorePosts(with error: ApiError) {
        view.refreshData(indicesToInsert: [], indicesToUpdate: [], animated: true)
    }
    
    func didFinishCheckingUrl(with type: UrlType) {
        
        switch type {
            
            case .innerReply(let num):
                router.presentPostController(posts: dataSource.posts, board: board, postNum: num)
            
            case .inner(let board, let opNum, let postNum):
            
                if opNum == num {
                    router.presentPostController(posts: dataSource.posts, board: board, postNum: postNum ?? opNum)
                }
                else {
                    router.pushAnotherThread(board: board, opNum: opNum, postNum: postNum)
                }
                
            case .outer(let url):
                router.open(url: url)
        }
    }
    
    //MARK: - Router Output
    func refreshWithNewPost() {
        
        needsToBeScrolledToBottom.toggle()
        update()
    }
    
    //MARK: - DataSourceOutput
    func didTapImage(index: Int, files: [File]) {
        router.presentImage(index: index, files: files)
    }
    
    func didTapUrl(url: URL) {
        interactor.didTapUrl(url: url)
    }
    
    func postNumberButtonPressed(replyingTo: String) {
        router.presentReplyController(board: board, threadNum: num, replyingTo: replyingTo)
    }
}
