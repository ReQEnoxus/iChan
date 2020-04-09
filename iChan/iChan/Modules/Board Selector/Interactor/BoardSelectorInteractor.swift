//
//  BoardSelectorInteractor.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardSelectorInteractor: BoardSelectorInteractorInput {
    
    weak var presenter: BoardSelectorInteractorOutput?
    var service: BoardsService!
    var boardCacheService: BoardCategoriesCacheService!
    
    func updateCachedCopy(with object: BoardCategories?) {
        
        if let object = object {
            boardCacheService.update(object)
        }
    }
    
    func manualRefresh() {
        
        service.getBoards { [weak self] response in
            
            switch response {
                
            case .failure(let error):
                self?.presenter?.didFinishObtainingBoards(with: error)
            case .success(let boards):
                
                let categories = BoardCategories(from: boards)
                
                if let cachedCategories = self?.boardCacheService.current() {
                    
                    if cachedCategories.hasPinndedBoards {
                        for board in cachedCategories.categories[0] {
                            categories.pin(board: board)
                        }
                    }
                    self?.boardCacheService.update(categories)
                    self?.presenter?.didFinishRefreshingBoards(boards: categories)
                }
                else {
                    
                    self?.boardCacheService.save(categories)
                    self?.presenter?.didFinishRefreshingBoards(boards: categories)
                }
            }
        }
    }
    
    func obtainBoards() {
        
        if let cachedBoards = boardCacheService.current() {
            presenter?.didFinishObtainingBoards(boards: cachedBoards)
        }
        else {
            
            service.getBoards { [weak self] response in
                
                switch response {
                    
                case .failure(let error):
                    self?.presenter?.didFinishObtainingBoards(with: error)
                case .success(let boards):
                    
                    let categories = BoardCategories(from: boards)
                    self?.presenter?.didFinishObtainingBoards(boards: categories)
                    self?.boardCacheService.save(categories)
                }
            }
        }
    }
}
