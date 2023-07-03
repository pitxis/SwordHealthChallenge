//
//  HttpRequestRepository.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Combine
import SwiftUI

class HttpRequestRepository<ImageCache: CacheServiceProtocol,
                            DataCache: CacheServiceProtocol,
                                NetworkMonitor: NetworkMonitorProtocol,
                            StoreProtocol: UserDefaultsServiceProtocol>:
                                RequestRepository where ImageCache.ObjectType == UIImage,
                                                        DataCache.ObjectType == CacheableObject<[BreedModel]>,
                                                            StoreProtocol.CodableType == [BreedModel] {
    private let httpService: HttpServiceProtocol
    private let imageCache: ImageCache
    private let dataCache: DataCache
    private let networkMonitor: NetworkMonitor
    private let storeService: StoreProtocol

    var isOffline = false
    var cancellables = Set<AnyCancellable>()

    init(httpService: HttpServiceProtocol,
         imageCache: ImageCache,
         dataCache: DataCache,
         networkMonitor: NetworkMonitor,
         storeService: StoreProtocol) {
        self.httpService = httpService
        self.imageCache = imageCache
        self.dataCache = dataCache
        self.networkMonitor = networkMonitor
        self.storeService = storeService

        self.networkMonitor.isOffline().sink(receiveValue: {[weak self] val in
            self?.isOffline = val == .offline
        })
        .store(in: &cancellables)
    }

    func networkStatus() -> AnyPublisher<NetworkStatus, Never> {
        self.networkMonitor.isOffline().eraseToAnyPublisher()
    }

    func getBreeds() -> AnyPublisher<[BreedModel], Never> {
        if isOffline {
            return self.getBreedsFromStorage()
        }

       return self.getBreedsFromHttpRequest()
    }

    func getBreedsFromStorage()  -> AnyPublisher<[BreedModel], Never> {
        if let res = self.storeService.loadCacheFromUserDefaults() {
            dataCache.removeAll()
            let cachable = CacheableObject(res)
            dataCache.insert(cachable, for: "Breeds")
            return Just(res).eraseToAnyPublisher()
        }

        return Just([]).eraseToAnyPublisher()
    }

    func getBreedsFromHttpRequest() -> AnyPublisher<[BreedModel], Never>{
        let requestHeader = RequestBuilder.setupGet(APIPaths.breeds)

        guard let request = requestHeader.request else {
            return Just([]).eraseToAnyPublisher()
        }

        return self.httpService.get(request)
            .map { $0 }
            .decode(type: BreedListDTO.self, decoder: JSONDecoder())
            .map { [weak self] res in
                let result = res.map({
                    BreedModel(from: $0)
                })

                let cachable = CacheableObject<[BreedModel]>(result)

                self?.dataCache.insert(cachable, for: "Breeds")
                self?.storeService.saveCacheToUserDefaults(codableObject: result)
                return result
            }
            .mapAPIError()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    func searchBreeds(_ query: String, page: Int, limit: Int) -> AnyPublisher<[BreedModel], Never> {
        let requestHeader = RequestBuilder.setupGet(APIPaths.search, query: query, limit: limit, page: page)

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
        if let image = self.imageCache.get(for: path) {
            return Just(image).eraseToAnyPublisher()
        }

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
                    .map {
                        self.imageCache.insert($0, for: path)
                        return $0
                    }
                    .replaceError(with: nil)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .mapAPIError()
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
