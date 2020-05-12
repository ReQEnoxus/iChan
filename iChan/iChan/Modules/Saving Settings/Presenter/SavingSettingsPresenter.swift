//
//  SavingSettingsPresenter.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SavingSettingsPresenter: SavingSettingsViewOutput, SavingSettingsInteractorOutput {
    
    weak var view: SavingSettingsViewInput!
    var interactor: SavingSettingsInteractorInput!
    var dataSource: SavingSettingsDataSource!
    
    //MARK: - View Output
    func viewDidLoad() {
        
        view.configureNavBar()
        view.registerDataSource(dataSource)
        interactor.obtainCurrentStrategy()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        interactor.changeSavingStrategy(to: indexPath.row)
    }
    
    //MARK: - Interactor Output
    func didFinishChangingStrategy(to raw: Int) {
        
        dataSource.options.forEach({ $0.isSelected = false })
        dataSource.options[raw].isSelected = true
        view.reloadData()
    }
    
    func didObtainCurrentStrategy(_ strategy: Int) {
        dataSource.options[strategy].isSelected = true
    }
}
