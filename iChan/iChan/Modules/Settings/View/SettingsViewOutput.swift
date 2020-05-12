//
//  SettingsViewOutput.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol SettingsViewOutput: AnyObject {
    
    /// tells presenter that view did load and initial setup should be performed
    func viewDidLoad()
    
    /// tells presenter that user has selected the cell at given index path
    /// - Parameter indexPath: index of the target cell
    func didSelectItem(at indexPath: IndexPath)
}
