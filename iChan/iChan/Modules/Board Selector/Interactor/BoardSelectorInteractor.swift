//
//  BoardSelectorInteractor.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardSelectorInteractor: BoardSelectorInteractorInput {
    
    var presenter: BoardSelectorInteractorOutput!
    let service: BoardsService = BoardsServiceImpl()
    
    // TODO: check for cached copy
    func obtainBoards() {
        
        service.getBoards { [weak self] response in
            
            switch response {
                
                case .failure(let error):
                    print(error)
                case .success(let boards):
                    self?.presenter.didFinishObtainingBoards(boards: BoardCategories(from: boards))
            }
        }
    }
}
