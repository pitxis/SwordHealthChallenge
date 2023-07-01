//
//  MockCacheWrapper.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 30/06/2023.
//

import Foundation
import UIKit
@testable import DogsWithSwords

public class MockCacheWrapper<Key, Value>: CustomCacheProtocol where Key: NSString, Value: AnyObject {

    private lazy var cache = [KeyType: ObjectType]()

    public var countLimit: Int = 0

    let cacheSystem = NSCache<KeyType, ObjectType>()

    public func object(forKey key: KeyType) -> ObjectType? {
        cache[key]
    }

    public func setObject(_ obj: ObjectType, forKey key: KeyType) {
        cache[key] = obj
    }

    public func setObject(_ obj: ObjectType, forKey key: KeyType, cost: Int) {
        cache[key] = obj
    }

    public func removeObject(forKey key: KeyType) {
        cache.removeValue(forKey: key)
    }

    public func removeAllObjects() {
        cache.removeAll()
    }

    public typealias KeyType = Key
    public typealias ObjectType = Value
}
