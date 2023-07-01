//
//  MockApiSession.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 30/06/2023.
//

import Foundation
import Combine
@testable import DogsWithSwords

class MockAPISession: APISessionProtocol {
    var data: Data = Data()
    var response: HTTPURLResponse = HTTPURLResponse()
    var error: URLError?

    func changeData(data: Data) {
        self.data = data
    }

    func changeResponse(response: HTTPURLResponse) {
        self.response = response
    }

    private func getOutput() -> (data: Data, response: URLResponse) {
        return (data: self.data, response: self.response)
    }

    func dataTaskPublisher(for url: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let err = error {
            return Fail(error: err).eraseToAnyPublisher()
        } else {
            return Just(getOutput())
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
    }

    func dataTaskPublisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let err = error {
            return Fail(error: err).eraseToAnyPublisher()
        } else {
            return Just(getOutput())
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
    }
}
