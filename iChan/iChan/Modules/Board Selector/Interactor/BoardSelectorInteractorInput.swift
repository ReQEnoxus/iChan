//
//  BoardSelectorInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorInteractorInput: AnyObject {
    
    /// tell interactor to get boards
    func obtainBoards()
    
    /// tells interactor to update cached copy of board categories
    /// - Parameter object: object to save
    func updateCachedCopy(with object: BoardCategories?)
    
    /// tells interactor that manual refresh is requested
    func manualRefresh()
    
    /// tells interactor to perform search
    /// - Parameter query: query to search by
    func performSearch(by query: String)
}
