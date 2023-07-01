//
//  DIStatic.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation


struct DIContainer {
    static var imageCache = ImageCache<ImageCacheType>(cache: ImageCacheType())
}
