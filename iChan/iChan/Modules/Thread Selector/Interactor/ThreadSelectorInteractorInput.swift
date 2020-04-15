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
    func loadMoreThreads(board: Board?, mode: ThreadSelectorMode?)
    
    /// tells interactor to refresh threads from current board
    /// - Parameter board: board from which threads should be retreived
    /// - Parameter mode: if specified, uses different mechanism for loading threads
    func refreshThreads(board: Board?, mode: ThreadSelectorMode?)
    
    /// tells interactor that some url was tapped
    /// - Parameter url: tapped url
    func didTapUrl(url: URL)
    
    /// tells interactor to save thread into persistent storage
    /// - Parameter board: board
    /// - Parameter num: OP-number
    func saveThread(board: String, num: String)
    
    /// tells interactor to delete thread from persistent storage
    /// - Parameter board: board
    /// - Parameter num: OP-number
    func deleteThread(board: String, num: String)
}
