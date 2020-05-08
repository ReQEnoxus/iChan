//
//  ReplyConfigurator.swift
//  iChan
//
//  Created by Enoxus on 04.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class ReplyConfigurator {
    
    class func configureModule(board: String, threadNum: String, replyingTo: String?) -> UIViewController {
        
        let view = ReplyViewController()
        let presenter = ReplyPresenter()
        let router = ReplyRouter()
        let interactor = ReplyInteractor()
        let postingService = PostingServiceImpl()
        let dataSource = ReplyDataSourceImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.board = board
        presenter.threadNum = threadNum
        presenter.replyingTo = replyingTo
        presenter.dataSource = dataSource
        
        dataSource.presenter = presenter
        
        interactor.postingService = postingService
        interactor.presenter = presenter
        
        router.view = view
        
        let viewToPresent = UINavigationController(rootViewController: view)
        viewToPresent.modalPresentationStyle = .fullScreen
        
        return viewToPresent
    }
}
