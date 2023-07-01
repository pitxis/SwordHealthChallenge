//
//  HttpService.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

import Combine
import SwiftUI

public struct HttpService<Session: APISessionProtocol,
                          ImageCache: CacheServiceProtocol>: HttpServiceProtocol where ImageCache.ObjectType == UIImage {
    private let session: Session

    private let imageCache: ImageCache

    // TODO: DI this
    init(session: Session, imageCache: ImageCache = DIContainer.imageCache) {
        self.session = session
        self.imageCache = imageCache
    }

    public func get(_ request: URLRequest) -> AnyPublisher<Data, APIError> {
        return self.session.dataTaskPublisher(for: request)
            .retry(3)
            .mapResponse()
            .map { data -> Data in
                return data
            }
            .mapAPIError()
            .eraseToAnyPublisher()
    }

    public func fetch(imageURL: URL) -> AnyPublisher<UIImage, APIError> {
        if let image = imageCache.get(for: imageURL) {
            return Just(image)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }

        return self.session.dataTaskPublisher(for: imageURL)
            .retry(3)
            .mapResponse()
            .tryMap { data -> UIImage in
                if let image = UIImage(data: data) {
                    self.imageCache.insert(image, for: imageURL)
                    return image
                }
                throw APIError(.cannotDecodeRawData, description: "Image Error")
            }
            .mapAPIError()
            .subscribe(on: DispatchQueue.global(qos: .background) )
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
