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
    
    var mainRealm: Realm? = try? Realm(configuration: .defaultConfiguration)
    var observerTokens = [NotificationToken]()
    
    func registerObserver<T: Object>(on type: T.Type, onUpdate: @escaping ([Int], [Int], [Int]) -> Void) {
        
        guard let token = mainRealm?.objects(type).observe({ block in
            
            switch block {
                
                case .update(_, let deletions, let insertions, let modifications):
                    onUpdate(deletions, insertions, modifications)
                    
                default: break
            }
        }) else {
            return
        }
        
        observerTokens.append(token)
    }
    
    func delete<T>(object: T) where T : RealmConvertible {
        
        try? mainRealm?.write {
            
            mainRealm?.delete(object.toRealmModel())
        }
    }
    
    func delete<T>(object: T) where T : Object {
        
        try? mainRealm?.write {
            
            mainRealm?.delete(object)
        }
    }
    
    func deleteAll<T: Object>(type: T.Type) {
        
        try? mainRealm?.write {
            
            mainRealm?.delete(mainRealm!.objects(type))
        }
    }
    
    func save<T>(_ object: T) where T : RealmConvertible {
        
        try? mainRealm?.write {
            
            mainRealm?.add(object.toRealmModel())
        }
    }
    
    func update<T>(object: T) where T : RealmConvertible {
        
        try? mainRealm?.write {
            
            mainRealm?.add(object.toRealmModel(), update: .modified)
        }
    }
    
    func get<T>(type: T.Type, by predicate: NSPredicate?) -> [T] where T : Object {
        
        guard let realm = mainRealm else { return [] }
        
        if let predicate = predicate {
            return Array(realm.objects(T.self).filter(predicate))
        }
        else {
            return Array(realm.objects(T.self))
        }
    }
    
    func get<T>(type: T.Type, by primaryKey: String) -> T? where T : Object {
        
        guard let realm = mainRealm else { return nil }
        
        return realm.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
}
