//
//  Board.swift
//  iChan
//
//  Created by Enoxus on 07/03/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

/// class that represents particular board
class Board: Codable {
    
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

extension Board: RealmConvertible {
    
    func toRealmModel() -> Object {
        
        let model = BoardModel()
        model.id = id
        model.name = name
        
        return model
    }
}
