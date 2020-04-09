//
//  BoardModel.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class BoardModel: Object {
    
    dynamic var id: String = String()
    dynamic var name: String = String()
    
    override class func primaryKey() -> String? {
        return #keyPath(BoardModel.id)
    }
}
