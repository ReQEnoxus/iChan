//
//  BoardsDataSourceProtocol.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol BoardsDataSourceProtocol: UITableViewDataSource {
    
    var boardCategories: BoardCategories? { get set }
    func titleForHeaderInSection(section: Int) -> String?
    func pinItem(at: IndexPath)
    func unpinItem(at: IndexPath)
}
