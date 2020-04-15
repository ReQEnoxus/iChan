//
//  ThreadSelectorConfigurator.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ThreadSelectorConfigurator {
    
    class func configureModule(board: Board) -> UIViewController {
        
        let view = ThreadSelectorViewController()
        let presenter = ThreadSelectorPresenter()
        let interactor = ThreadSelectorInteractor()
        let dataSource = ThreadSelectorDataSourceImpl()
        let service = BoardThreadsServiceImpl()
        let urlService = UrlCheckerServiceImpl()
        let router = ThreadSelectorRouter()
        let threadStorageService = ThreadStorageServiceImpl()
        let replyService = ReplyServiceImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.dataSource = dataSource
        presenter.board = board
        presenter.router = router
        
        dataSource.presenter = presenter
        
        interactor.presenter = presenter
        interactor.service = service
        interactor.urlService = urlService
        interactor.threadStorageService = threadStorageService
        interactor.replyService = replyService
        
        router.view = view
        
        return view
    }
    
    class func configureModule(mode: ThreadSelectorMode, title: String) -> UIViewController {
        
        let view = ThreadSelectorViewController()
        let presenter = ThreadSelectorPresenter()
        let interactor = ThreadSelectorInteractor()
        let dataSource = ThreadSelectorDataSourceImpl()
        let service = BoardThreadsServiceImpl()
        let urlService = UrlCheckerServiceImpl()
        let router = ThreadSelectorRouter()
        let threadStorageService = ThreadStorageServiceImpl()
        let replyService = ReplyServiceImpl()
        let cache = (UIApplication.shared.delegate as! AppDelegate).threadCache

        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.dataSource = dataSource
        presenter.router = router
        presenter.mode = mode
        presenter.title = title
        
        if mode == .cached {
            cache.subscribe(interactor)
        }
        
        dataSource.presenter = presenter
        
        interactor.presenter = presenter
        interactor.service = service
        interactor.urlService = urlService
        interactor.cache = cache
        interactor.threadStorageService = threadStorageService
        interactor.replyService = replyService
        
        if mode == .realm {
            interactor.observeThreadStorage()
        }
        
        router.view = view
        
        return view
    }
}
