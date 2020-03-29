//
//  ThreadSelectorViewOutput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorViewOutput: AnyObject {
    
    /// tells presenter to load more threads
    func loadMoreThreads()
    
    /// tells presenter to perform initial setup
    func initialSetup()
    
    /// tells presenter that refresh is requested (by pull-to-refresh or initial load)
    func refreshRequested()
    
    /// tells presenter that user collapsed the cell
    /// - Parameter indexPath: index of target cell
    func didPressedCollapse(on indexPath: IndexPath)
    
    /// tells presenter that particular cell was selected
    /// - Parameter indexPath: index of target cell
    /// - Parameter collapsed: flag indicates whether the requested cell was collapsed
    func didSelectItem(at indexPath: IndexPath, collapsed: Bool)
}
