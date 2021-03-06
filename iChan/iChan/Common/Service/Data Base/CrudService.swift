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
    /// - Parameter order: order of the collection
    /// - Parameter completion: block that is called when data is ready
    func get<T: Object>(type: T.Type, order: Order?, by predicate: NSPredicate?, completion: @escaping ([T]) -> Void)
    
    /// gets specific object by primary key
    /// - Parameter type: type of the object
    /// - Parameter primaryKey: primary key
    func get<T: Object>(type: T.Type, by primaryKey: String, completion: @escaping (T?) -> Void)
    
    /// delete object from the realm
    /// - Parameter object: object to delete
    func delete<T: RealmConvertible>(object: T)
    
    /// delete object from the realm
    /// - Parameter object: object to delete
    func delete<T: Object>(object: T)
    
    /// deletes object from the realm
    /// - Parameter type: type of deleted object
    /// - Parameter predicate: predicate to filter objects
    func delete<T: Object>(type: T.Type, predicate: NSPredicate)
    
    /// delete all objects of given type from realm
    /// - Parameter type: type of the objects
    func deleteAll<T: Object>(type: T.Type)
    
    /// registers observer that gets notified everytime the collection of given types get mutated
    /// - Parameter type: type to receive notifications about
    /// - Parameter onUpdate: action to perform when notification received, accepts deletions, insertions and modifications indices as params
    /// - Parameter order: order of the collection
    func registerObserver<T: Object>(on type: T.Type, order: Order?, onUpdate: @escaping ([Int], [Int], [Int]) -> Void)
}
