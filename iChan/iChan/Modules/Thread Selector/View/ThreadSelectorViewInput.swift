//
//  ThreadSelectorViewInput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorViewInput: AnyObject {
    
    /// set name of the current board to display in navbar
    /// - Parameter name: name of the board
    func setBoardName(_ name: String)
    
    /// tells tableview to completely refresh its data
    func refreshData()
    
    /// tells tableview indices of rows that should be inserted
    /// - Parameter indicesToRefresh: indices of rows that should be inserted
    func refreshData(indicesToRefresh: [IndexPath])
    
    /// connects datasource to tableview
    /// - Parameter dataSource: datasource to be connected
    func connectDataSource(_ dataSource: ThreadSelectorDataSource)
    
    /// tells view to collapse cell at given indexpath
    /// - Parameter indexPath: index of target cell
    func collapseCell(at indexPath: IndexPath)
    
    /// tells view to expand previously collapsed cell
    /// - Parameter indexPath: index of target cell
    func expandCell(at indexPath: IndexPath)
    
    /// tells view to stop and hide loading indicator in footer view
    func stopLoadingIndicator()
    
    /// tells view to display tableview
    func displayTableView()
    
    /// tells view to display error view
    func displayErrorView()
}
