//
//  RequestRepository.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import SwiftUI
import Combine

protocol RequestRepository {
    func getBreeds() -> AnyPublisher<[BreedModel], Never>

    func searchBreeds(_ query: String, page: Int,
                 limit: Int) -> AnyPublisher<[BreedModel], Never>

    func getImage(path: String) -> AnyPublisher<UIImage?, Never>

    func networkStatus() -> AnyPublisher<NetworkStatus, Never>
}
