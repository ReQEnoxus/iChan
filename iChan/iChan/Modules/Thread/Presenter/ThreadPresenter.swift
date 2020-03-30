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
        
        view.connectDataSource(dataSource)
    }
    
    func loadThread() {
        interactor.loadThread(board: board, num: num)
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
    
    //MARK: - DataSourceOutput
    func didTapImage(index: Int, files: [File]) {
        router.presentImage(index: index, files: files)
    }
}
