//
//  BoardCategoriesCacheServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardCategoriesCacheServiceImpl: BoardCategoriesCacheService {
    
    private let crudService: CrudService = RealmCrudServiceImpl()
    
    func update(_ new: BoardCategories) {
        crudService.update(object: new)
    }
    
    func current() -> BoardCategories? {
        
        let model = crudService.get(type: BoardCategoriesModel.self, by: nil).first
        
        guard let modelUnwrapped = model else { return nil }
        
        let boardCategories = BoardCategories()
        
        if !modelUnwrapped.favourites.isEmpty {
            boardCategories.hasPinndedBoards = true
        }
        
        boardCategories.categoryNames = Array(modelUnwrapped.categoryNames)
        
        if boardCategories.hasPinndedBoards {
            boardCategories.categories.append(Array(modelUnwrapped.favourites).map({ Board(id: $0.id, name: $0.name) }))
        }
        
        boardCategories.categories.append(Array(modelUnwrapped.other).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.tech).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.adult).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.games).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.politics).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.userBoards).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.art).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.thematics).map({ Board(id: $0.id, name: $0.name) }))
        boardCategories.categories.append(Array(modelUnwrapped.japanese).map({ Board(id: $0.id, name: $0.name) }))
        
        return boardCategories
    }
    
    func delete() {
        crudService.deleteAll(type: BoardCategoriesModel.self)
    }
    
    func save(_ object: BoardCategories) {
        crudService.save(object)
    }
}
