//
//  APIPath.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

struct APIPaths {
    static let baseURL = URL(string: API.baseURL)!

    static var breeds: URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "v1/breeds"
        return urlComponents?.url
    }

    static var search: URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "v1/breeds/search"
        return urlComponents?.url
    }

    static func image(with id: String) -> URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "v1/images/\(id)"
        return urlComponents?.url
    }
}
