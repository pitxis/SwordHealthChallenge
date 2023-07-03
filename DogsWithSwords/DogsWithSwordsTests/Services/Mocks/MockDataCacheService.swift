//
//  MockDataCacheService.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import Foundation
import SwiftUI
@testable import DogsWithSwords

typealias MockDataCacheType = MockCacheWrapper<NSString, CacheableObject<[BreedModel]>>

class MockDataCacheService<CustomCache: CustomCacheProtocol>: CacheServiceProtocol {
    var mockCache: MockCacheWrapper<NSString, CacheableObject<[BreedModel]>>

    init(cache: MockCacheWrapper<NSString, CacheableObject<[BreedModel]>>) {
        self.mockCache = cache
    }

    subscript(key: String) -> CacheableObject<[BreedModel]>? {
        get {
            return get(for: key)
        }
        set {
            insert(newValue, for: key)
        }
    }

    func get(for key: String) -> CacheableObject<[BreedModel]>? {
        return mockCache.object(forKey: key as NSString)
    }

    func insert(_ data: CacheableObject<[BreedModel]>?, for key: String) {
        if let lData = data {
            mockCache.setObject(lData, forKey: key as NSString)
        }
    }

    func remove(for key: String) {
        mockCache.removeObject(forKey: key as NSString)
    }

    func removeAll() {
        mockCache.removeAllObjects()
    }
}
