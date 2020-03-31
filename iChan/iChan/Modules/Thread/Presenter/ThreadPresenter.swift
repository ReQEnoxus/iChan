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
    
    //MARK: - View Output
    func initialSetup() {
        
        view.displayLoadingView()
        view.connectDataSource(dataSource)
    }
    
    func loadThread() {
        interactor.loadThread(board: board, num: num)
    }
    
    func update() {
        interactor.loadNewPosts(board: board, num: num, offset: dataSource.posts.count + 1)
    }
    
    //MARK: - Interactor Output
    func didFinishLoadingThread(thread: Thread) {
        
        dataSource.posts = thread.posts
        view.displayTableView()
        view.refreshData()
    }
    
    func didFinishLoadingThread(with error: ApiError) {
        
        print(error.localizedDescription)
        view.displayErrorView()
    }
    
    func didFinishLoadingMorePosts(posts: [Post]) {
        
        dataSource.appendPosts(posts) { [weak self] idx in
            self?.view.refreshData(indicesToRefresh: idx)
        }
    }
    
    func didFinishLoadingMorePosts(with error: ApiError) {
        view.refreshData(indicesToRefresh: [])
    }
    
    //MARK: - DataSourceOutput
    func didTapImage(index: Int, files: [File]) {
        router.presentImage(index: index, files: files)
    }
}
