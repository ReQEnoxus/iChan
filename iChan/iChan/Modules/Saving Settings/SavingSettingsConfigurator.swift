//
//  SavingSettingsConfigurator.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SavingSettingsConfigurator {
    
    class func configureModule() -> UIViewController {
        
        let view = SavingSettingsViewController()
        let presenter = SavingSettingsPresenter()
        let dataSource = SavingSettingsDataSourceImpl()
        let interactor = SavingSettingsInteractor()
        let strategyService = SavingStrategyServiceImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.dataSource = dataSource
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.strategyService = strategyService
        
        return view
    }
}
