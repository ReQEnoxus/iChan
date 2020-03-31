//
//  ThreadViewInput.swift
//  iChan
//
//  Created by Enoxus on 30/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadViewInput: AnyObject {
    
    /// tells tableview to completely refresh its data
    func refreshData()
    
    func refreshData(indicesToRefresh: [IndexPath])
    
    /// connects datasource to tableview
    /// - Parameter dataSource: datasource to be connected
    func connectDataSource(_ dataSource: ThreadDataSource)
    
    /// tells view to display tableview
    func displayTableView()
    
    /// tells view to display error view
    func displayErrorView()
    
    /// tells view to display loading view
    func displayLoadingView()
}
