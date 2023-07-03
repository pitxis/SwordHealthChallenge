//
//  DIStatic.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation


struct DIContainer {
    static var networkMonitor = NetworkMonitor()
    static var imageCache = ImageCache<ImageCacheType>(cache: ImageCacheType())
    static var storeBreedsService = UserDefaultsService<[BreedModel]>()
    static var dataCache = DataCache<DataCacheType>(cache: DataCacheType())
    static var httpService = HttpService(session: URLRequestSession())
    static var httpRequestRepository = HttpRequestRepository(httpService: DIContainer.httpService,
                                                             imageCache: DIContainer.imageCache,
                                                             dataCache: dataCache,
                                                             networkMonitor: networkMonitor,
                                                             storeService: storeBreedsService)
}
