//
//  SettingsConfigurator.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SettingsConfigurator {
    
    class func configureModule() -> UIViewController {
        
        let view = SettingsViewController()
        let presenter = SettingsPresenter()
        let dataSource = SettingsDataSourceImpl()
        let router = SettingsRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.dataSource = dataSource
        presenter.router = router
        
        router.view = view
        
        return view
    }
}
