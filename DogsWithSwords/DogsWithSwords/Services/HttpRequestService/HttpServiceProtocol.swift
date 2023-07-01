//
//  HttpServiceProtocol.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation
import Combine
import SwiftUI

public protocol HttpServiceProtocol {
    func get(_ request: URLRequest) -> AnyPublisher<Data, APIError>
    func fetch(imageURL: URL) -> AnyPublisher<UIImage, APIError>
}
