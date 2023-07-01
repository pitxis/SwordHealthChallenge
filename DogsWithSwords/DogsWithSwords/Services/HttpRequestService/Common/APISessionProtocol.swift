//
//  APISessionProtocol.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Combine
import SwiftUI

public protocol APISessionProtocol {
    func dataTaskPublisher(for url: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}
