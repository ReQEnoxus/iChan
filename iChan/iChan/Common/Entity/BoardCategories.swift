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
    
    init(from response: BoardCategoriesResponse) {
        
        categories.append([])
        categoryNames.append("Избранное")
        
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
}
