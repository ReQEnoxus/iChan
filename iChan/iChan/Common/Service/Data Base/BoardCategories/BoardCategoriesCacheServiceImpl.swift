//
//  BoardCategoriesCacheServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardCategoriesCacheServiceImpl: BoardCategoriesCacheService {
    
    var crudService: CrudService!
    
    func update(_ new: BoardCategories) {
        
        current { [weak self] cached in

            if let cachedBoards = cached {

                if cachedBoards.hasPinnedBoards, new.hasPinnedBoards {

                    for category in new.categories[.zero] {

                        if !cachedBoards.categories[.zero].contains(where: { $0.id == category.id }) {
                            cachedBoards.categories[.zero].append(category)
                        }
                    }
                }
                else if !cachedBoards.hasPinnedBoards, new.hasPinnedBoards {

                    cachedBoards.categories.insert(new.categories[.zero], at: .zero)
                    cachedBoards.categoryNames.insert(new.categoryNames[.zero], at: .zero)
                }

                if !new.recentlyUnpinned.isEmpty {

                    for category in new.recentlyUnpinned {
                        cachedBoards.categories[.zero].removeAll(where: { $0.id == category.id })
                    }

                    if cachedBoards.categories[.zero].isEmpty {
                        cachedBoards.categoryNames.remove(at: .zero)
                        cachedBoards.categories.remove(at: .zero)
                    }

                    new.recentlyUnpinned.removeAll()
                }

                self?.crudService.update(object: cachedBoards)
            }
        }
    }
    
    func current(completion: @escaping (BoardCategories?) -> Void) {
        
        crudService.get(type: BoardCategoriesModel.self, order: nil, by: nil) { categories in
            
            guard let modelUnwrapped = categories.first else {
                
                DispatchQueue.main.async {
                    completion(.none)
                }
                
                return
            }
            
            let boardCategories = BoardCategories()
            
            boardCategories.categoryNames = Array(modelUnwrapped.categoryNames)
            
            if boardCategories.hasPinnedBoards {
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
            
            DispatchQueue.main.async {
                completion(boardCategories)
            }
        }
    }
    
    func delete() {
        crudService.deleteAll(type: BoardCategoriesModel.self)
    }
    
    func save(_ object: BoardCategories) {
        crudService.save(object)
    }
}
