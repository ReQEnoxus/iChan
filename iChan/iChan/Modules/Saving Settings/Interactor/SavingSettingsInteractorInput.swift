//
//  SavingSettingsInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SavingSettingsInteractorInput: AnyObject {
    
    /// tells interactor to change saving strategy
    /// - Parameter raw: raw value of desired strategy
    func changeSavingStrategy(to raw: Int)
    
    /// tells interactor to obtain currently active strategy
    func obtainCurrentStrategy()
}
