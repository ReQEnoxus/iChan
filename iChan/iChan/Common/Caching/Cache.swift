//
//  Cache.swift
//  iChan
//
//  Created by Enoxus on 11/04/2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol UniquelyIdentifiable {
    
    var id: String { get }
}

final class Cache<Key: Hashable, Value: UniquelyIdentifiable>: NSObject, NSCacheDelegate {
    
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    private var keys = [Key]()
    
    private var subscribers = [CacheSubscriber]()
    
    override init() {
        
        super.init()
        wrapped.delegate = self
    }
    
    func insert(_ value: Value, forKey key: Key) {
        
        let entry = Entry(value: value)
        
        if wrapped.object(forKey: WrappedKey(key)) == nil {
            
            keys.insert(key, at: 0)
        }
        
        wrapped.setObject(entry, forKey: WrappedKey(key))
        
        subscribers.forEach {
            $0.cacheDidUpdate()
        }
    }

    func value(forKey key: Key) -> Value? {
        
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }

    func removeValue(forKey key: Key) {
        
        wrapped.removeObject(forKey: WrappedKey(key))
        keys.removeAll(where: { $0 == key })
        
        subscribers.forEach {
            $0.cacheDidUpdate()
        }
    }
    
    func allEntries() -> [Value] {
        
        var result = [Value]()
        
        for key in keys {
            if let valueForKey = value(forKey: key) {
                result.append(valueForKey)
            }
        }
        
        return result
    }
    
    subscript(key: Key) -> Value? {
        
        get {
            return value(forKey: key)
        }
        
        set {
            guard let value = newValue else {
                
                removeValue(forKey: key)
                return
            }

            insert(value, forKey: key)
        }
    }
    
    func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
        
        if let entry = obj as? Entry {
            
            keys.removeAll(where: { $0.hashValue == entry.value.id.hashValue })
        }
        subscribers.forEach {
            $0.cacheDidUpdate()
        }
    }
}

private extension Cache {
    
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

private extension Cache {
    
    final class Entry {
        
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}

extension Cache {
    
    func subscribe(_ subscriber: CacheSubscriber) {
        subscribers.append(subscriber)
    }
    
    func unsubscribe(_ subscriber: CacheSubscriber) {
        subscribers.removeAll(where: { $0 === subscriber })
    }
}
