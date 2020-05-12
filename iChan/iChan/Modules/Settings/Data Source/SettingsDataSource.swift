//
//  SettingsDataSource.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsDataSource: UITableViewDataSource {
    
    /// routes to available settings pages
    var settingsPages: [Route] { get set }
}
