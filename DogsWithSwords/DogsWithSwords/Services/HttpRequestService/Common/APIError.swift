//
//  APIError.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

public struct APIError: Error {
    let errorType: URLError.Code
    let urlString: String?
    let description: String

    init(_ code: URLError.Code, description: String) {
        self.description = description
        self.urlString = nil
        self.errorType = code
    }

    init(_ code: Int, description: String) {
        self.description = description
        self.urlString = nil
        self.errorType = URLError.Code(rawValue: code)
    }

    init(_ error: URLError) {
        self.urlString = error.failureURLString
        self.description = error.localizedDescription
        self.errorType = error.code
    }
}
