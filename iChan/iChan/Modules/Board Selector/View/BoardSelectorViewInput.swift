//
//  BoardSelectorViewInput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorViewInput: AnyObject {
    
    /// connects datasource to the tableview
    /// - Parameter dataSource: datasource to be connected
    func connectDataSource(_ dataSource: BoardsDataSourceProtocol)
    
    /// tells the view to refresh data in tableview
    func refreshData()
    
    /// tells view to visually display pinned item
    /// - Parameter index: index of the row to be inserted
    /// - Parameter sectionAdded: tells the view if section needs to be inserted
    func pinItem(at index: IndexPath, sectionAdded: Bool)
    
    /// tells view to visually display that item was unpinned
    /// - Parameter index: index of the row to be deleted
    /// - Parameter sectionDeleted: tells the view if the section needs to be deleted
    func unpinItem(at index: IndexPath, sectionDeleted: Bool)
    
    func displayTableView()
    
    func displayLoadingView()
    
    func displayErrorView()
}
