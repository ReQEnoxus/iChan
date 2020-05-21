//
//  BoardSelectorViewOutput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorViewOutput: AnyObject {
    
    /// tells presenter that particular cell was selected
    /// - Parameter indexPath: index of the selected cell
    func didSelectRow(at indexPath: IndexPath)
    
    /// initial setup of the view
    func initialSetup()
    
    /// asks presenter for title for particular section
    /// - Parameter section: section index
    func titleForHeaderInSection(section: Int) -> String?
    
    /// tells presenter that user wants to pin an item
    /// - Parameter at: index of the item to pin
    func pinItem(at: IndexPath)
    
    /// tells presenter that user wants to unpin an item
    /// - Parameter at: index of the item to unpin
    func unpinItem(at: IndexPath)
    
    /// tells presenter that user has requested the refresh while module is in error state
    func refreshInErrorState()
    
    /// tells presenter that user has requested the refresh by pull-to-refresh
    func refreshRequested()
    
    /// tells presenter to perform search of boards with current query
    /// - Parameter query: filter query
    func searchRequested(query: String)
}
