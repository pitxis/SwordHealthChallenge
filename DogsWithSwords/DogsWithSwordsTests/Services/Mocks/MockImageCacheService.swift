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

    subscript(key: URL) -> UIImage? {
        get {
            return get(for: key)
        }
        set {
            insert(newValue, for: key)
        }
    }

    func get(for url: URL) -> UIImage? {
        return mockCache.object(forKey: url.absoluteString as NSString)
    }

    func insert(_ image: UIImage?, for url: URL) {
        if let img = image {
            mockCache.setObject(img, forKey: url.absoluteString as NSString)
        }
    }

    func remove(for url: URL) {
        mockCache.removeObject(forKey: url.absoluteString as NSString)
    }

    func removeAll() {
        mockCache.removeAllObjects()
    }
}
