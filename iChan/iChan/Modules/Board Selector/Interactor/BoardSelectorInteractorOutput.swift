//
//  BoardSelectorInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorInteractorOutput: AnyObject {
    
    /// tell interactor's output that the boards are obtained
    /// - Parameter boards: obtained boards
    func didFinishObtainingBoards(boards: BoardCategories)
    
    func didFinishObtainingBoards(with error: ApiError)
}
