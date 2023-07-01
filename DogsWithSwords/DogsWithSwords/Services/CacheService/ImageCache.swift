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
    public func get(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }

        if let image = nsCache.object(forKey: url.absoluteString as NSString) {
            let decodedImage = image.decodedImage()
            return decodedImage
        }
        return nil
    }

    public func insert(_ image: UIImage?, for url: URL) {
        guard let image = image else { return remove(for: url) }

        if nsCache.object(forKey: url.absoluteString as NSString) != nil {
            return
        }

        let decodedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        nsCache.setObject(decodedImage, forKey: url.absoluteString as NSString)
    }

    public func remove(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        nsCache.removeObject(forKey: url.absoluteString as NSString)
    }

    public func removeAll() {
        nsCache.removeAllObjects()
    }

    public subscript(_ key: URL) -> UIImage? {
        get {
            return get(for: key)
        }
        set {
            return insert(newValue, for: key)
        }
    }
}
