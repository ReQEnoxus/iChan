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
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.board = board
        presenter.threadNum = threadNum
        presenter.replyingTo = replyingTo
        
        router.view = view
        
        let viewToPresent = UINavigationController(rootViewController: view)
        viewToPresent.modalPresentationStyle = .fullScreen
        
        return viewToPresent
    }
}
