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
    
    dynamic var fileDataUrl: String? = nil
    dynamic var thumbnailDataUrl: String? = nil
    
    override class func primaryKey() -> String? {
        return #keyPath(FileModel.path)
    }
}
