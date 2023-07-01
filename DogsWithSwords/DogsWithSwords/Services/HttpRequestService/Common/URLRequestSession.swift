//
//  URLRequestSession.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Combine
import SwiftUI

public class URLRequestSession: APISessionProtocol {
    public func dataTaskPublisher(for url: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }

    public func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
}
