//
//  SavingStrategyServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class SavingStrategyServiceImpl: SavingStrategyService {
    
    let defaults = UserDefaults.standard
    
    func getCurrentStrategy() -> SavingStrategy {
        
        let raw = defaults.integer(forKey: UserDefaultsKeys.savingStrategy.rawValue) 
        
        guard let strategy = SavingStrategy(rawValue: raw) else {
            return .textOnly
        }
        
        return strategy
    }
    
    func setCurrentStrategy(_ strategy: SavingStrategy) {
        defaults.set(strategy.rawValue, forKey: UserDefaultsKeys.savingStrategy.rawValue)
    }
}
