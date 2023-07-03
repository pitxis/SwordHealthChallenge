//
//  DataCache.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 02/07/2023.
//

import Foundation

class CacheableObject<T>: NSObject {
    let object: T

    init(_ object: T) {
        self.object = object
    }

    func get() -> T {
        return object
    }
}

typealias DataCacheType = NSCacheWrapper<NSString, CacheableObject<[BreedModel]>>

final class DataCache<CustomCache: CustomCacheProtocol>: CacheServiceProtocol where
CustomCache.KeyType == NSString, CustomCache.ObjectType == CacheableObject<[BreedModel]> {

    public typealias ObjectType = CustomCache.ObjectType
    private let lock = NSLock()

    var nsCache: CustomCache

    init(cache: CustomCache) {
        nsCache = cache
    }

    public func get(for key: String) -> CacheableObject<[BreedModel]>? {
        lock.lock(); defer { lock.unlock() }

        if let data = nsCache.object(forKey: key as NSString) {
            return data
        }

        return nil
    }

    public func insert(_ data: CacheableObject<[BreedModel]>?, for key: String) {
        lock.lock(); defer { lock.unlock() }
        if let lData = data {
            nsCache.setObject(lData, forKey: key as NSString)
        }
    }

    public func remove(for key: String) {
        lock.lock(); defer { lock.unlock() }
        nsCache.removeObject(forKey: key as NSString)
    }

    public func removeAll() {
        nsCache.removeAllObjects()
    }

    public subscript(key: String) -> CacheableObject<[BreedModel]>? {
        get {
            return get(for: key)
        }
        set {
            insert(newValue, for: key)
        }
    }
}
