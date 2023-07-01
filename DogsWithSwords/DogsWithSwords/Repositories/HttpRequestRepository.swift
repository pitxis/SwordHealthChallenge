//
//  HttpRequestRepository.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Combine
import SwiftUI


class HttpRequestRepository: RequestRepository {
    let httpService: HttpServiceProtocol

    init(httpService: HttpServiceProtocol) {
        self.httpService = httpService
    }

    func getBreeds() -> AnyPublisher<[BreedModel], Never> {
        let requestHeader = RequestBuilder.setupGet(APIPaths.breeds)

        guard let request = requestHeader.request else {
            return Just([]).eraseToAnyPublisher()
        }

        return self.httpService.get(request)
            .map { $0 }
            .decode(type: BreedListDTO.self, decoder: JSONDecoder())
            .map { res in
                res.map({
                    BreedModel(from: $0)
                })
            }
            .mapAPIError()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func searchBreeds(_ query: String, offset: Int, limit: Int) -> AnyPublisher<[BreedModel], Never> {
        let requestHeader = RequestBuilder.setupGet(APIPaths.search, query: query)

        guard let request = requestHeader.request else {
            return Just([]).eraseToAnyPublisher()
        }

        return self.httpService.get(request)
            .map { $0 }
            .decode(type: BreedListDTO.self, decoder: JSONDecoder())
            .map { res in
                res.map({
                    BreedModel(from: $0)
                })
            }
            .mapAPIError()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func getImage(path: String) -> AnyPublisher<UIImage?, Never> {
        let requestHeader = RequestBuilder.setupGet(APIPaths.image(with: path))

        guard let request = requestHeader.request else {
            return Just(nil).eraseToAnyPublisher()
        }

         return httpService.get(request)
            .map { $0 }
            .decode(type: ImageSearchDTO.self, decoder: JSONDecoder())
            .map { dto in
                self.httpService
                    .fetch(imageURL: URL(string: dto.url)!)
                   .map {$0}
                   .replaceError(with: nil)
                   .eraseToAnyPublisher()
            }
            .switchToLatest()
            .mapAPIError()
            .replaceError(with: nil)
            .eraseToAnyPublisher()

    }


}
