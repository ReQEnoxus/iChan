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
        let strategyService = SavingStrategyServiceImpl()
        let attachmentLoaderService = AttachmentLoaderServiceImpl()
        let fileSystemService = FileManagingServiceImpl()
        let crudService = RealmCrudServiceImpl()
        
        attachmentLoaderService.fileManagingService = fileSystemService
        threadStorageService.fileManager = fileSystemService
        
        threadStorageService.crudService = crudService
        
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
        interactor.strategyService = strategyService
        interactor.attachmentLoaderService = attachmentLoaderService

        router.view = view
        router.presenter = presenter
        
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
        let strategyService = SavingStrategyServiceImpl()
        let attachmentLoaderService = AttachmentLoaderServiceImpl()
        let fileSystemService = FileManagingServiceImpl()
        let crudService = RealmCrudServiceImpl()
        
        threadStorageService.crudService = crudService
        
        attachmentLoaderService.fileManagingService = fileSystemService
        threadStorageService.fileManager = fileSystemService

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
        interactor.strategyService = strategyService
        interactor.attachmentLoaderService = attachmentLoaderService
        
        if mode == .realm {
            interactor.observeThreadStorage()
        }
        
        router.view = view
        router.presenter = presenter
        
        return view
    }
}
