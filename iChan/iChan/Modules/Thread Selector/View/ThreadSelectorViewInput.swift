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
    
    func refreshData(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath])
    
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
    /// - Parameter style: style of error message
    func displayErrorView(style: ErrorMessageStyle)
    
    /// tells view to display loading view
    func displayLoadingView()
    
    /// tells view that pull-to-refresh functionality should not be accessible
    func disablePullToRefresh()
    
    /// sets the boolean flag that is deciding which set of contextual items will be used in the thread selector view
    func configureHistoryContextualActions()
    
    /// displays loading indicator
    func displayLoadingHud()
    
    /// hides loading indicator
    func hideLoadingHud()
    
    /// tells if the view is present in the view hierarchy
    var isVisible: Bool { get }
}
