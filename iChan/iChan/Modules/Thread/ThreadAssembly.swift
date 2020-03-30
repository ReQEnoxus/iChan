//
//  ThreadAssembly.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class ThreadAssembly {
    
    class func configureModule(board: String, num: String) -> UIViewController {
        
        let view = ThreadViewController()
        let presenter = ThreadPresenter()
        let interactor = ThreadInteractor()
        let dataSource = ThreadDataSourceImpl()
        let router = ThreadRouter()
        let threadService = BoardThreadsServiceImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.dataSource = dataSource
        presenter.router = router
        presenter.board = board
        presenter.num = num
        
        interactor.presenter = presenter
        interactor.service = threadService
        
        dataSource.presenter = presenter
        
        router.view = view
        
        return view
    }
}
