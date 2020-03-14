//
//  BoardSelectorInteractorOutput.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol BoardSelectorInteractorOutput: AnyObject {
    
    func didFinishObtainingBoards(boards: BoardCategories)
}
