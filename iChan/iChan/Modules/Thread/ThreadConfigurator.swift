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
        let replyService = ReplyServiceImpl()
        let threadStorageService = ThreadStorageServiceImpl()
        let cache = (UIApplication.shared.delegate as! AppDelegate).threadCache
        let fileSystemService = FileManagingServiceImpl()
        let crudService = RealmCrudServiceImpl()
        
        threadStorageService.fileManager = fileSystemService
        threadStorageService.crudService = crudService
        
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
        interactor.replyService = replyService
        interactor.cache = cache
        interactor.threadStorageService = threadStorageService
        
        dataSource.presenter = presenter
        
        router.view = view
        router.presenter = presenter
                
        return view
    }
}
