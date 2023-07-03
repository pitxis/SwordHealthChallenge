//
//  UserDefaultsServiceProtocol.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import Foundation

protocol UserDefaultsServiceProtocol<CodableType> {
    associatedtype CodableType: Codable

    func saveCacheToUserDefaults(codableObject: CodableType)
    func loadCacheFromUserDefaults() -> CodableType?
}
