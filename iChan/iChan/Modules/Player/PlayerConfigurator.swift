//
//  PlayerConfigurator.swift
//  iChan
//
//  Created by Enoxus on 19.04.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class PlayerConfigurator {
    
    class func configureModule(media url: URL) -> UIViewController {
        
        let view = PlayerViewController()
        let presenter = PlayerPresenter()
        let interactor = PlayerInteractor()
        let router = PlayerRouter()
        let videoRepository = VideoRepositoryImpl()
        let fileManager = FileManagingServiceImpl()
        let crudService = RealmCrudServiceImpl()
        
        videoRepository.fileManager = fileManager
        videoRepository.crudService = crudService
        
        view.presenter = presenter
        view.modalPresentationStyle = .fullScreen
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.url = url
        
        interactor.presenter = presenter
        interactor.videoRepository = videoRepository
        
        router.view = view
        
        return view
    }
}
