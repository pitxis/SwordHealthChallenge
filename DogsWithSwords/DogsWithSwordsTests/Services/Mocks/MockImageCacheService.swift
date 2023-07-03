//
//  MockImageCacheService.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 30/06/2023.
//

import Foundation
import SwiftUI
@testable import DogsWithSwords

typealias MockImageCacheType = MockCacheWrapper<NSString, UIImage>

class MockImageCacheService<CustomCache: CustomCacheProtocol>: CacheServiceProtocol {
    var mockCache: MockCacheWrapper<NSString, UIImage>

    init(cache: MockCacheWrapper<NSString, UIImage>) {
        self.mockCache = cache
    }

    subscript(key: String) -> UIImage? {
        get {
            return get(for: key)
        }
        set {
            insert(newValue, for: key)
        }
    }

    func get(for key: String) -> UIImage? {
        return mockCache.object(forKey: key as NSString)
    }

    func insert(_ image: UIImage?, for key: String) {
        if let img = image {
            mockCache.setObject(img, forKey: key as NSString)
        }
    }

    func remove(for key: String) {
        mockCache.removeObject(forKey: key as NSString)
    }

    func removeAll() {
        mockCache.removeAllObjects()
    }
}
