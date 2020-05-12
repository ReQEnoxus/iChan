//
//  SettingsRouter.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SettingsRouter: SettingsRouterInput {
    
    weak var view: UIViewController!
    
    func navigateToPage(_ route: Route) {
        
        let vc: UIViewController
        
        switch route {
            
        case .savingSettings:
            vc = SavingSettingsConfigurator.configureModule()
        }
        
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
