//
//  PostModel.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PostModel: Object {
    
    dynamic var comment = String()
    dynamic var name = String()
    dynamic var op = 0
    dynamic var num = String()
    dynamic var date = String()
    dynamic var repliesStr = String()
    let files = List<FileModel>()
}
