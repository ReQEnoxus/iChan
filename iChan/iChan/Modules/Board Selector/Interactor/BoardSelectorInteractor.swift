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
    var boardSearchService: BoardSearchService!
    
    func updateCachedCopy(with object: BoardCategories?) {
        
        if let object = object {
            boardCacheService.update(object)
        }
    }
    
    func manualRefresh() {
        
        service.getBoards { [weak self] response in
            
            switch response {
                
            case .failure(let error):
                
                self?.boardCacheService.current { cachedBoards in
                    
                    if let boards = cachedBoards {
                        self?.presenter?.didFinishRefreshingBoards(boards: boards)
                    }
                    else {
                        self?.presenter?.didFinishObtainingBoards(with: error)
                    }
                }
            case .success(let boards):
                
                let categories = BoardCategories(from: boards)
                
                self?.boardCacheService.current() { cachedCategories in
                    
                    guard let cachedCategories = cachedCategories else {
                        
                        self?.boardCacheService.save(categories)
                        self?.presenter?.didFinishRefreshingBoards(boards: categories)
                        return
                    }
                    
                    if cachedCategories.hasPinndedBoards {
                        for board in cachedCategories.categories[0] {
                            categories.pin(board: board)
                        }
                    }
                    self?.boardCacheService.update(categories)
                    self?.presenter?.didFinishRefreshingBoards(boards: categories)
                }
            }
        }
    }
    
    func performSearch(by query: String) {
        
        boardSearchService.filterBoards(with: query) { [weak self] filtered in
            
            self?.presenter?.didPerformSearch(boards: filtered)
        }
    }
    
    func obtainBoards() {
        
        boardCacheService.current() { [weak self] cachedBoards in
            
            guard let cachedBoards = cachedBoards else {
                
                self?.service.getBoards { [weak self] response in
                    
                    switch response {
                        
                    case .failure(let error):
                        self?.presenter?.didFinishObtainingBoards(with: error)
                    case .success(let boards):
                        
                        let categories = BoardCategories(from: boards)
                        self?.presenter?.didFinishObtainingBoards(boards: categories)
                        self?.boardCacheService.save(categories)
                    }
                }
                
                return
            }
            
            self?.presenter?.didFinishObtainingBoards(boards: cachedBoards)
        }
    }
}
