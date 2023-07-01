//
//  CustomCacheWrapper.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

public class NSCacheWrapper<Key, Value>: CustomCacheProtocol where Key: AnyObject,
                                                                        Value: AnyObject {
    private lazy var cache: NSCache<Key, Value> = {
        var cache = NSCache<Key, Value>()
        cache.countLimit = 100
        return cache
    }()

    public var countLimit: Int = 0

    let cacheSystem = NSCache<KeyType, ObjectType>()

    public func object(forKey key: KeyType) -> ObjectType? {
        cache.object(forKey: key)
    }

    public func setObject(_ obj: ObjectType, forKey key: KeyType) {
        cache.setObject(obj, forKey: key)
    }

    public func setObject(_ obj: ObjectType, forKey key: KeyType, cost: Int) {
        cache.setObject(obj, forKey: key, cost: cost)
    }

    public func removeObject(forKey key: KeyType) {
        cache.removeObject(forKey: key)
    }

    public func removeAllObjects() {
        cache.removeAllObjects()
    }

    public typealias KeyType = Key
    public typealias ObjectType = Value
}
