//
//  CustomCacheProtocol.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

public protocol CustomCacheProtocol<KeyType, ObjectType> {
    associatedtype KeyType
    associatedtype ObjectType

    func object(forKey key: KeyType) -> ObjectType?

    func setObject(_ obj: ObjectType, forKey key: KeyType)

    func removeObject(forKey key: KeyType)

    func removeAllObjects()

    var countLimit: Int { get set }
}
