//
//  BoardsDataSource.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

protocol BoardsDataSource: UITableViewDataSource, AnyObject {
    
    /// board categories model to be working with
    var boardCategories: BoardCategories? { get set }
    
    /// title for a specifict section
    /// - Parameter section: section index
    func titleForHeaderInSection(section: Int) -> String?
    
    /// tell the datasource to pin item
    /// - Parameter at: index of the item to be pinned
    func pinItem(at: IndexPath)
    
    /// tell the datasource to unpin item
    /// - Parameter at: index of the item to be unpinned
    func unpinItem(at: IndexPath)
    
    /// returns board object for given indexpath
    /// - Parameter indexPath: indexpath of the board in table
    func board(for indexPath: IndexPath) -> Board?
}
