//
//  UserDefaultsService.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import Foundation
import SwiftUI


class UserDefaultsService<CodableObject>: UserDefaultsServiceProtocol where CodableObject: Codable {
    typealias CodableType = CodableObject

    func saveCacheToUserDefaults(codableObject: CodableType) {
        let userDefaults = UserDefaults.standard

        do {
            let encoded = try JSONEncoder().encode(codableObject)
            userDefaults.set(encoded, forKey: "cachedData")
            userDefaults.synchronize()
        } catch {
            assertionFailure("Error saving cache data: \(error)")
        }

    }

    func loadCacheFromUserDefaults() -> CodableType? {
        let userDefaults = UserDefaults.standard

        if let cacheData = userDefaults.object(forKey: "cachedData") as? Data {
            do {
                let unarchivedCache = try JSONDecoder().decode(CodableObject.self, from: cacheData)
                return unarchivedCache
            } catch {
                assertionFailure("Error loading cache data: \(error)")
            }
        }

        return nil
    }

}
