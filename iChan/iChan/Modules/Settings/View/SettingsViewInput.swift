//
//  SettingsViewInput.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewInput: AnyObject {
    
    /// tells view to register given data source to table view
    /// - Parameter dataSource: data source to be registered
    func registerDataSource(_ dataSource: UITableViewDataSource)
    
    /// tells view to configure its navigation bar
    func configureNavBar()
    
    /// tells view to reload data in table view
    func reloadData()
}
