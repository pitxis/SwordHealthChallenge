//
//  DataCacheTests.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import XCTest
@testable import DogsWithSwords

class DataCacheTests: XCTestCase {
    var dataCache: DataCache<MockDataCacheType>!

    override func setUp() {
        super.setUp()
        let mockDataCacheService = MockCacheWrapper<NSString, CacheableObject<Array<BreedModel>>>()
        dataCache = DataCache(cache: mockDataCacheService)
    }

    override func tearDown() {
        dataCache = nil
        super.tearDown()
    }

    func testCacheSetValue() {
        let key = "key"
        let value = [DefaultModels.breedsModel]
        let cachable = CacheableObject(value)

        dataCache[key] = cachable

        let cachedValue = dataCache.get(for: key)
        XCTAssertEqual(cachedValue?.get(), value, "Cached value should match the set value")
    }

    func testCacheRemoveValue() {
        let key = "Key"
        let value = [DefaultModels.breedsModel]
        let cachable = CacheableObject(value)

        dataCache[key] = cachable
        dataCache.remove(for: key)

        let cachedValue = dataCache[key]
        XCTAssertNil(cachedValue, "Cached value should be nil after removing it")
    }

    func testCacheClear() {
        let key1 = "key1"
        let key2 = "Key2"
        let value = [DefaultModels.breedsModel]
        let cachable = CacheableObject(value)

        dataCache.insert(cachable, for: key1)
        dataCache.insert(cachable, for: key2)
        dataCache.removeAll()

        let cachedValue1 = dataCache[key1]
        let cachedValue2 = dataCache[key2]
        XCTAssertNil(cachedValue1, "Cache value should be nil after clearing the cache")
        XCTAssertNil(cachedValue2, "Cache value should be nil after clearing the cache")
    }
}
