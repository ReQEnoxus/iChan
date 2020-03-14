//
//  BoardCategories.swift
//  iChan
//
//  Created by Enoxus on 08/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class BoardCategories {
    
    var categories: [[Board]] = []
    var categoryNames: [String] = []
    var hasPinndedBoards = false
    
    init(from response: BoardCategoriesResponse) {
        
        categories.append(response.other)
        categoryNames.append("Разное")
        
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
        
        categories.append(response.tech)
        categoryNames.append("Техника и софт")
        
        categories.append(response.japanese)
        categoryNames.append("Японская культура")
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
