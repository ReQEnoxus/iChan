//
//  BoardSelectorConfigurator.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class BoardSelectorConfigurator {
    
    class func configureModule() -> UIViewController {
        
        let view = BoardSelectorViewController()
        let presenter = BoardSelectorPresenter()
        let interactor = BoardSelectorInteractor()
        let router = BoardSelectorRouter()
        let dataSource = BoardsDataSourceImpl()
        let service = BoardsServiceImpl()
        let cacheService = BoardCategoriesCacheServiceImpl()
        let crudService = RealmCrudServiceImpl()
        
        cacheService.crudService = crudService
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.dataSource = dataSource
        
        dataSource.presenter = presenter
        
        interactor.presenter = presenter
        interactor.service = service
        interactor.boardCacheService = cacheService
        
        router.view = view
        
        return view
    }
}
