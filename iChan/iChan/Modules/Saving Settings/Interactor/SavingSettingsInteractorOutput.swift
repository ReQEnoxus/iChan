//
//  SavingSettingsInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SavingSettingsInteractorOutput: AnyObject {
    
    /// tells presenter that strategy is changed
    /// - Parameter raw: strategy raw value
    func didFinishChangingStrategy(to raw: Int)
    
    /// tells presenter that strategy is retrieved
    /// - Parameter strategy: currently active strategy
    func didObtainCurrentStrategy(_ strategy: Int)
}
