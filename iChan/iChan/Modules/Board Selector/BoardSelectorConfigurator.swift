//
//  BoardSelectorConfigurator.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardSelectorConfigurator {
    
    class func configureModule() -> BoardSelectorViewController {
        
        let view = BoardSelectorViewController()
        let presenter = BoardSelectorPresenter()
        let interactor = BoardSelectorInteractor()
        let router = BoardSelectorRouter()
        let dataSource = BoardsDataSource()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.dataSource = dataSource
        
        interactor.presenter = presenter
        
        return view
    }
}
