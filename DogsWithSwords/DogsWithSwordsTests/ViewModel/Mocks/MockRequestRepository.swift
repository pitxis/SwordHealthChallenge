//
//  MockRequestRepository.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import Combine
import SwiftUI
@testable import DogsWithSwords

class MockRequestRepository: RequestRepository {
    public var result: [BreedModel] = []

    func getBreeds() -> AnyPublisher<[DogsWithSwords.BreedModel], Never> {
        return Just(result).eraseToAnyPublisher()
    }

    func searchBreeds(_ query: String, page: Int, limit: Int) -> AnyPublisher<[DogsWithSwords.BreedModel], Never> {
        return Just(result).eraseToAnyPublisher()
    }

    func getImage(path: String) -> AnyPublisher<UIImage?, Never> {
        return Just(UIImage()).eraseToAnyPublisher()
    }

    func networkStatus() -> AnyPublisher<DogsWithSwords.NetworkStatus, Never> {
        return Just(.online).eraseToAnyPublisher()
    }
}
