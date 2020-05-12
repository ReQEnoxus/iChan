//
//  SavingSettingsViewInput.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol SavingSettingsViewInput: AnyObject {
    
    /// tells view to register given data source to table view
    /// - Parameter dataSource: data source to be registered
    func registerDataSource(_ dataSource: UITableViewDataSource)
    
    /// tells view to configure its navigation bar
    func configureNavBar()
    
    /// tells view to reload data in table view
    func reloadData()
    
    /// tells view to set a checkmark at selected cell
    /// - Parameter indexPath: where to set a checkmark
    func setCheckmark(at indexPath: IndexPath)
}
