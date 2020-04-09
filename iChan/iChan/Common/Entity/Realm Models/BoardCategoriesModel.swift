//
//  BoardCategoriesModel.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class BoardCategoriesModel: Object {
    
    /// storing only one instance so id is always same
    dynamic var id = 0
    let categoryNames: List<String> = List()
    let favourites: List<BoardModel> = List()
    let adult: List<BoardModel> = List()
    let games: List<BoardModel> = List()
    let politics: List<BoardModel> = List()
    let userBoards: List<BoardModel> = List()
    let other: List<BoardModel> = List()
    let art: List<BoardModel> = List()
    let thematics: List<BoardModel> = List()
    let tech: List<BoardModel> = List()
    let japanese: List<BoardModel> = List()
    
    override class func primaryKey() -> String? {
        return #keyPath(BoardCategoriesModel.id)
    }
}
