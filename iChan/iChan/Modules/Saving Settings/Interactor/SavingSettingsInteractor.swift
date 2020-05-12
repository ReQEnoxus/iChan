//
//  SavingSettingsInteractor.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SavingSettingsInteractor: SavingSettingsInteractorInput {
    
    weak var presenter: SavingSettingsInteractorOutput!
    var strategyService: SavingStrategyService!
    
    func changeSavingStrategy(to raw: Int) {
        
        guard let strategy = SavingStrategy(rawValue: raw) else {
            return
        }
        
        strategyService.setCurrentStrategy(strategy)
        presenter.didFinishChangingStrategy(to: raw)
    }
    
    func obtainCurrentStrategy() {
        presenter.didObtainCurrentStrategy(strategyService.getCurrentStrategy().rawValue)
    }
}
