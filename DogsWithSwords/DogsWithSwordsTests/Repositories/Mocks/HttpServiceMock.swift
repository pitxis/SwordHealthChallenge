//
//  HttpServiceMock.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import Foundation
import XCTest
import Combine
@testable import DogsWithSwords

class HttpServiceMock: HttpServiceProtocol {
    var data = Data()
    var image: UIImage? = UIImage()

    func get(_ request: URLRequest) -> AnyPublisher<Data, APIError> {
        Just(data).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }

    func fetch(imageURL: URL) -> AnyPublisher<UIImage, APIError> {
        guard let img = image else {
            return Fail(error: APIError(400, description: "No Image")).eraseToAnyPublisher()
        }
        return Just(img).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
}

