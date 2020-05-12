//
//  SettingsPresenter.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SettingsPresenter: SettingsViewOutput {
    
    weak var view: SettingsViewInput!
    var dataSource: SettingsDataSource!
    var router: SettingsRouterInput!
    
    func viewDidLoad() {
        
        view.configureNavBar()
        view.registerDataSource(dataSource)
        view.reloadData()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        router.navigateToPage(dataSource.settingsPages[indexPath.row])
    }
}
