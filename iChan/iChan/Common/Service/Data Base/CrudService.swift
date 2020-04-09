//
//  CrudService.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

protocol CrudService: AnyObject {
    
    /// saves the object into realm
    /// - Parameter object: object to save
    func save<T: RealmConvertible>(_ object: T)
    
    /// updates the object in the realm
    /// - Parameter object: object to update
    func update<T: RealmConvertible>(object: T)
    
    /// gets all the objects from the realm matching the predicate
    /// - Parameter type: type of the objects
    /// - Parameter predicate: optional predicate
    func get<T: Object>(type: T.Type, by predicate: NSPredicate?) -> [T]
    
    /// delete object from the realm
    /// - Parameter object: object to delete
    func delete<T: RealmConvertible>(object: T)
    
    /// delete all objects of given type from realm
    /// - Parameter type: type of the objects
    func deleteAll<T: Object>(type: T.Type)
}
