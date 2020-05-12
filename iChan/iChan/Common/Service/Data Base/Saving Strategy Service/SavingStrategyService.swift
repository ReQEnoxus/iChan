//
//  SavingStrategyService.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SavingStrategyService: AnyObject {
    
    /// returns currently used saving strategy
    func getCurrentStrategy() -> SavingStrategy
    
    /// sets new saving strategy
    /// - Parameter strategy: strategy to be set
    func setCurrentStrategy(_ strategy: SavingStrategy)
}
