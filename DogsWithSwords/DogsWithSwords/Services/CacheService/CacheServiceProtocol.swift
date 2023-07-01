//
//  CacheServiceProtocol.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

public protocol CacheServiceProtocol<ObjectType>: AnyObject {
    associatedtype ObjectType

    func get(for url: URL) -> ObjectType?
    func insert(_ image: ObjectType?, for url: URL)
    func remove(for url: URL)
    func removeAll()

    subscript(_ url: URL) -> ObjectType? { get set }
}
