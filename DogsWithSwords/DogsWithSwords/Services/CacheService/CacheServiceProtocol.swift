//
//  CacheServiceProtocol.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

public protocol CacheServiceProtocol<ObjectType>: AnyObject {
    associatedtype ObjectType

    func get(for key: String) -> ObjectType?
    func insert(_ image: ObjectType?, for key: String)
    func remove(for key: String)
    func removeAll()

    subscript(_ key: String) -> ObjectType? { get set }
}
