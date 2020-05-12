//
//  SavingSettingsDataSource.swift
//  iChan
//
//  Created by Enoxus on 12.05.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol SavingSettingsDataSource: UITableViewDataSource {
    
    /// options of saving
    var options: [Option] { get set }
}
