//
//  BoardCategories.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

/// structure that contains boards with categories and also manages favourites (should be cached)
class BoardCategories {
    
    var categories: [[Board]] = []
    var categoryNames: [String] = []
    var hasPinndedBoards = false
    
    init(from response: BoardCategoriesResponse) {
        
        categories.append(response.other)
        categoryNames.append("Разное")
        
        categories.append(response.tech)
        categoryNames.append("Техника и софт")
        
        categories.append(response.adult)
        categoryNames.append("Взрослым")
        
        categories.append(response.games)
        categoryNames.append("Игры")
        
        categories.append(response.politics)
        categoryNames.append("Политика")
        
        categories.append(response.userBoards)
        categoryNames.append("Пользовательские")
        
        categories.append(response.art)
        categoryNames.append("Творчество")
        
        categories.append(response.thematics)
        categoryNames.append("Тематика")
        
        categories.append(response.japanese)
        categoryNames.append("Японская культура")
    }
    
    init() {
        
    }
    
    func pin(board: Board) -> Bool {
        
        if !hasPinndedBoards {
            
            categoryNames.insert("Избранное", at: 0)
            categories.insert([board], at: 0)
            hasPinndedBoards = true
            
            return true
        }
        else if !categories[0].contains(where: { $0.id == board.id }) {
            
            categories[0].append(board)
            
            return true
        }
        
        return false
    }
    
    func unpin(board: Board) -> Bool {
        
        if hasPinndedBoards {
            
            let beforeRemove = categories[0].count
            
            categories[0].removeAll(where: { $0.id == board.id })
            
            let afterRemove = categories[0].count
            
            if categories[0].isEmpty {
                
                categories.remove(at: 0)
                categoryNames.remove(at: 0)
                hasPinndedBoards = false
            }
            
            return afterRemove < beforeRemove
        }
        
        return false
    }
}

extension BoardCategories: RealmConvertible {
    
    func toRealmModel() -> Object {
        
        let model = BoardCategoriesModel()
        
        if hasPinndedBoards {
            
            categories[0].forEach({ model.favourites.append($0.toRealmModel() as! BoardModel) })
            categories[1].forEach({ model.other.append($0.toRealmModel() as! BoardModel) })
            categories[2].forEach({ model.tech.append($0.toRealmModel() as! BoardModel) })
            categories[3].forEach({ model.adult.append($0.toRealmModel() as! BoardModel) })
            categories[4].forEach({ model.games.append($0.toRealmModel() as! BoardModel) })
            categories[5].forEach({ model.politics.append($0.toRealmModel() as! BoardModel) })
            categories[6].forEach({ model.userBoards.append($0.toRealmModel() as! BoardModel) })
            categories[7].forEach({ model.art.append($0.toRealmModel() as! BoardModel) })
            categories[8].forEach({ model.thematics.append($0.toRealmModel() as! BoardModel) })
            categories[9].forEach({ model.japanese.append($0.toRealmModel() as! BoardModel) })
        }
        else {
            
            categories[0].forEach({ model.other.append($0.toRealmModel() as! BoardModel) })
            categories[1].forEach({ model.tech.append($0.toRealmModel() as! BoardModel) })
            categories[2].forEach({ model.adult.append($0.toRealmModel() as! BoardModel) })
            categories[3].forEach({ model.games.append($0.toRealmModel() as! BoardModel) })
            categories[4].forEach({ model.politics.append($0.toRealmModel() as! BoardModel) })
            categories[5].forEach({ model.userBoards.append($0.toRealmModel() as! BoardModel) })
            categories[6].forEach({ model.art.append($0.toRealmModel() as! BoardModel) })
            categories[7].forEach({ model.thematics.append($0.toRealmModel() as! BoardModel) })
            categories[8].forEach({ model.japanese.append($0.toRealmModel() as! BoardModel) })
        }
        
        model.categoryNames.append(objectsIn: categoryNames)
        
        return model
    }
}
