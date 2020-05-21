//
//  BoardSelectorViewInput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorViewInput: AnyObject {
    
    /// returns true if searchErrorView is currently visible
    var isDisplayingSearchErrorView: Bool { get }
    
    /// connects datasource to the tableview
    /// - Parameter dataSource: datasource to be connected
    func connectDataSource(_ dataSource: BoardsDataSource)
    
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
    
    /// tells view to display tableview and remove all other views
    func displayTableView()
    
    /// tells view to display loading animation and remove all other views
    func displayLoadingView()
    
    /// tells view to display error view and remove all other views
    /// - Parameter type: type of the error
    func displayErrorView(type: ErrorType)
}
