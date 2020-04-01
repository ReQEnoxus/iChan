//
//  ThreadSelectorInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorInteractorInput: AnyObject {
    
    /// tells interactor to load more threads from given board
    /// - Parameter board: board from which threads should be loaded
    func loadMoreThreads(board: Board)
    
    /// tells interactor to refresh threads from current board
    /// - Parameter board: board from which threads should be retreived
    func refreshThreads(board: Board)
    
    func didTapUrl(url: URL)
}
