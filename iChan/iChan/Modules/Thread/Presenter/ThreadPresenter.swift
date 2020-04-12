//
//  ThreadPresenter.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ThreadPresenter: ThreadViewOutput, ThreadInteractorOutput, ThreadDataSourceOutput {
    
    weak var view: ThreadViewInput!
    var interactor: ThreadInteractorInput!
    var router: ThreadRouterInput!
    var dataSource: ThreadDataSource!
    
    var board: String!
    var num: String!
    var postNum: String?
    
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
    
    //MARK: - Interactor Output
    func didFinishLoadingThread(thread: Thread, replyLoadNeeded: Bool, idxToInsert: [IndexPath], idxToUpdate: [IndexPath]) {
        
        if replyLoadNeeded {
            
            dataSource.posts = thread.posts
            view.refreshData(indicesToInsert: idxToInsert, indicesToUpdate: idxToUpdate, animated: false)
            view.displayTableView()
            if let requestedPostNum = postNum {
                router.presentPostController(posts: thread.posts, postNum: requestedPostNum)
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
    }
    
    func didFinishLoadingMorePosts(with error: ApiError) {
        view.refreshData(indicesToInsert: [], indicesToUpdate: [], animated: true)
    }
    
    func didFinishCheckingUrl(with type: UrlType) {
        
        switch type {
            
            case .innerReply(let num):
                router.presentPostController(posts: dataSource.posts, postNum: num)
            
            case .inner(let board, let opNum, let postNum):
            
                if opNum == num {
                    router.presentPostController(posts: dataSource.posts, postNum: postNum ?? opNum)
                }
                else {
                    router.pushAnotherThread(board: board, opNum: opNum, postNum: postNum)
                }
                
            case .outer(let url):
                router.open(url: url)
        }
    }
    
    //MARK: - DataSourceOutput
    func didTapImage(index: Int, files: [File]) {
        router.presentImage(index: index, files: files)
    }
    
    func didTapUrl(url: URL) {
        interactor.didTapUrl(url: url)
    }
}
