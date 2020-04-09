//
//  RealmConvertible.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmConvertible: AnyObject {
    
    /// converts the model to realm object
    func toRealmModel() -> Object
}
