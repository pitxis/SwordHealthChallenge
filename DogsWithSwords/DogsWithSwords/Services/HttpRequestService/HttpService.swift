//
//  HttpService.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

import Combine
import SwiftUI

public struct HttpService<Session: APISessionProtocol>: HttpServiceProtocol  {
    private let session: Session

    init(session: Session) {
        self.session = session
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
        return self.session.dataTaskPublisher(for: imageURL)
            .retry(3)
            .mapResponse()
            .tryMap { data -> UIImage in
                if let image = UIImage(data: data) {
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
