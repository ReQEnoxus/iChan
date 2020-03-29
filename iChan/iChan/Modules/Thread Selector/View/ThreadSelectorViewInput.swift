//
//  ThreadSelectorViewInput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorViewInput: AnyObject {
    
    func setBoardName(_ name: String)
    func refreshData()
    func refreshData(indicesToRefresh: [IndexPath])
    func connectDataSource(_ dataSource: ThreadSelectorDataSource)
    func collapseCell(at indexPath: IndexPath)
    func expandCell(at indexPath: IndexPath)
    func stopLoadingIndicator()
    func displayTableView()
    func displayErrorView()
}
