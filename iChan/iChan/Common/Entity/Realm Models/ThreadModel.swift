//
//  ThreadModel.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class ThreadModel: Object {
    
    dynamic var pkey = String()
    dynamic var filesCount = 0
    dynamic var postsCount = 0
    let posts = List<PostModel>()
    
    override class func primaryKey() -> String? {
        return #keyPath(ThreadModel.pkey)
    }
}
