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
    
    /// tells presenter that some error has occured during obtaining
    /// - Parameter error: error that has occured
    func didFinishObtainingBoards(with error: ApiError)
    
    /// tells presenter that boards are successfully refreshed
    /// - Parameter boards: refreshed boards
    func didFinishRefreshingBoards(boards: BoardCategories)
}
