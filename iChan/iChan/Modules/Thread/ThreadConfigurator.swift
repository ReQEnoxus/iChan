//
//  ThreadConfigurator.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ThreadConfigurator {
    
    class func configureModule(board: String, num: String, postNum: String?) -> UIViewController {
        
        let view = ThreadViewController()
        let presenter = ThreadPresenter()
        let interactor = ThreadInteractor()
        let dataSource = ThreadDataSourceImpl()
        let router = ThreadRouter()
        let threadService = BoardThreadsServiceImpl()
        let urlService = UrlCheckerServiceImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.dataSource = dataSource
        presenter.router = router
        presenter.board = board
        presenter.num = num
        presenter.postNum = postNum
        
        interactor.presenter = presenter
        interactor.service = threadService
        interactor.urlService = urlService
        
        dataSource.presenter = presenter
        
        router.view = view
        
        return view
    }
}
