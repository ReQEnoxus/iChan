//
//  RealmCrudServiceImpl.swift
//  iChan
//
//  Created by Enoxus on 09/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCrudServiceImpl: CrudService {
    
    var observerTokens = [NotificationToken]()
    
    func registerObserver<T: Object>(on type: T.Type, order: Order?, onUpdate: @escaping ([Int], [Int], [Int]) -> Void) {
                    
        let realm = try! Realm()
        
        let objects = order != nil ? realm.objects(type).sorted(byKeyPath: order!.keyPath, ascending: order!.ascending) : realm.objects(type)
        
        let token = objects.observe({ block in
            
            switch block {
                
                case .update(_, let deletions, let insertions, let modifications):
                    onUpdate(deletions, insertions, modifications)
                    
                default: break
            }
        })
        
        observerTokens.append(token)
    }
    
    func delete<T>(object: T) where T : RealmConvertible {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            try? realm.write {
                
                realm.delete(object.toRealmModel())
            }
        }
    }
    
    func delete<T>(object: T) where T : Object {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            try? realm.write {
                
                realm.delete(object)
            }
        }
    }
    
    func delete<T: Object>(type: T.Type, predicate: NSPredicate) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            let objectsToDelete = realm.objects(type).filter(predicate)
            
            try? realm.write {
                
                realm.delete(objectsToDelete)
            }
        }
    }
    
    func deleteAll<T: Object>(type: T.Type) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            try? realm.write {
                
                realm.delete(realm.objects(type))
            }
        }
    }
    
    func save<T>(_ object: T) where T : RealmConvertible {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            try? realm.write {
                
                realm.add(object.toRealmModel())
            }
        }
    }
    
    func update<T>(object: T) where T : RealmConvertible {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            try? realm.write {
                
                realm.add(object.toRealmModel(), update: .modified)
            }
        }
    }
    
    func get<T>(type: T.Type, order: Order?, by predicate: NSPredicate?, completion: @escaping ([T]) -> Void) where T : Object {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            if let predicate = predicate {
                if let collectionOrder = order {
                    completion(Array(realm.objects(T.self).filter(predicate).sorted(byKeyPath: collectionOrder.keyPath, ascending: collectionOrder.ascending)))
                }
                else {
                     completion(Array(realm.objects(T.self).filter(predicate)))
                }
            }
            else {
                if let collectionOrder = order {
                    completion(Array(realm.objects(T.self).sorted(byKeyPath: collectionOrder.keyPath, ascending: collectionOrder.ascending)))
                }
                else {
                    completion(Array(realm.objects(T.self)))
                }
            }
            
        }
    }
    
    func get<T>(type: T.Type, by primaryKey: String, completion: @escaping (T?) -> Void) where T : Object {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            completion(realm.object(ofType: type, forPrimaryKey: primaryKey))
        }
    }
}
