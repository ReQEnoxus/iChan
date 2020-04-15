//
//  FileModel.swift
//  iChan
//
//  Created by Enoxus on 12/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class FileModel: Object {
    
    dynamic var path = String()
    dynamic var thumbnail = String()
    dynamic var displayName = String()
    
    dynamic var fileData: Data? = nil
    dynamic var thumbnailData: Data? = nil
    
    override class func primaryKey() -> String? {
        return #keyPath(FileModel.path)
    }
}
