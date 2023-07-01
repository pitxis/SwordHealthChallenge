//
//  Configuration.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
    static var pubKey: String {
        do {
            return try Configuration.value(for: "API_KEY")
        } catch {
            return ""
        }
    }

    static var baseURL: String {
        do {
            return try Configuration.value(for: "BASE_URL")
        } catch {
            return ""
        }
    }
}
