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
        let cache = (UIApplication.shared.delegate as! AppDelegate).threadCache

        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.dataSource = dataSource
        presenter.router = router
        presenter.mode = mode
        presenter.title = title
        
        if mode == .cached {
            cache.subscribe(presenter)
        }
        
        dataSource.presenter = presenter
        
        interactor.presenter = presenter
        interactor.service = service
        interactor.urlService = urlService
        interactor.cache = cache
        
        router.view = view
        
        return view
    }
}
