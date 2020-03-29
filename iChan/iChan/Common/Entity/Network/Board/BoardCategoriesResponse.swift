//
//  BoardCategoriesResponse.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

/// response which contains info about boards and categories
struct BoardCategoriesResponse: Codable {
    
    let adult: [Board]
    let games: [Board]
    let politics: [Board]
    let userBoards: [Board]
    let other: [Board]
    let art: [Board]
    let thematics: [Board]
    let tech: [Board]
    let japanese: [Board]
    
    enum CodingKeys: String, CodingKey {
        
        case adult = "Взрослым"
        case games = "Игры"
        case politics = "Политика"
        case userBoards = "Пользовательские"
        case other = "Разное"
        case art = "Творчество"
        case thematics = "Тематика"
        case tech = "Техника и софт"
        case japanese = "Японская культура"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        adult = try container.decode([Board].self, forKey: .adult)
        games = try container.decode([Board].self, forKey: .games)
        politics = try container.decode([Board].self, forKey: .politics)
        userBoards = try container.decode([Board].self, forKey: .userBoards)
        other = try container.decode([Board].self, forKey: .other)
        art = try container.decode([Board].self, forKey: .art)
        thematics = try container.decode([Board].self, forKey: .thematics)
        tech = try container.decode([Board].self, forKey: .tech)
        japanese = try container.decode([Board].self, forKey: .japanese)
    }
}
