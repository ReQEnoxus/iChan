//
//  BoardSelectorRouterProtocol.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorRouterInput {
    
    /// tells router to perform navigation to thread selector module
    /// - Parameter board: requested board
    func pushToThreadSelector(board: Board)
}
