//
//  ImageCache.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

import Foundation
import SwiftUI

 typealias ImageCacheType = NSCacheWrapper<NSString, UIImage>

public final class ImageCache<CustomCache: CustomCacheProtocol> {
    private let lock = NSLock()

    var nsCache: CustomCache

    init(cache: CustomCache) {
        self.nsCache = cache
    }
}

extension ImageCache: CacheServiceProtocol where CustomCache.KeyType == NSString,
                                                  CustomCache.ObjectType == UIImage {
    public func get(for key: String) -> UIImage? {
        lock.lock(); defer { lock.unlock() }

        if let image = nsCache.object(forKey: key as NSString) {
            let decodedImage = image.decodedImage()
            return decodedImage
        }
        return nil
    }

    public func insert(_ image: UIImage?, for key: String) {
        guard let image = image else { return remove(for: key) }

        if nsCache.object(forKey: key as NSString) != nil {
            return
        }

        let decodedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        nsCache.setObject(decodedImage, forKey: key as NSString)
    }

    public func remove(for key: String) {
        lock.lock(); defer { lock.unlock() }
        nsCache.removeObject(forKey: key as NSString)
    }

    public func removeAll() {
        nsCache.removeAllObjects()
    }

    public subscript(_ key: String) -> UIImage? {
        get {
            return get(for: key as String)
        }
        set {
            return insert(newValue, for: key as String)
        }
    }
}
