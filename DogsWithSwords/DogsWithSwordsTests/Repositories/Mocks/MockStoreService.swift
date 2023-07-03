//
//  MockStoreService.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import Foundation
@testable import DogsWithSwords

class MockStoreService: UserDefaultsServiceProtocol {
    var storage: CodableType = []

    func saveCacheToUserDefaults(codableObject: [DogsWithSwords.BreedModel]) {
        storage += codableObject
    }

    func loadCacheFromUserDefaults() -> [DogsWithSwords.BreedModel]? {
        return storage
    }

    typealias CodableType = [BreedModel]


}
