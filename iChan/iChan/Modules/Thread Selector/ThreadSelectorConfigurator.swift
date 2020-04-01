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
}
