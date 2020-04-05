//
//  PostConfigurator.swift
//  iChan
//
//  Created by Enoxus on 02/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

class PostConfigurator {
    
    class func configureModule(posts: [Post], num: String, parent: UIViewController) -> UIViewController {
        
        let view = PostViewController()
        let presenter = PostPresenter()
        let interactor = PostInteractor()
        let router = PostRouter()
        let urlService = UrlCheckerServiceImpl()
        let postView = PostView()
        
        view.presenter = presenter
        view.postView = postView
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.posts = posts
        presenter.initialNum = num
        
        interactor.presenter = presenter
        interactor.urlService = urlService
        
        router.view = view
        router.parentView = parent
        
        return view
    }
}
