//
//  ThreadSelectorInteractorInput.swift
//  iChan
//
//  Created by Enoxus on 15/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol ThreadSelectorInteractorInput: AnyObject {
    
    func loadMoreThreads(board: Board)
    func refreshThreads(board: Board)
}
