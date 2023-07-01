//
//  Publisher+Extension.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation
import Combine

extension Publisher {
    func mapAPIError() -> Publishers.MapError<Self, APIError> {
        mapError { err in

            var apiError: APIError

            if let urlErr = err as? URLError {
                apiError = APIError(urlErr)
            } else if let apiErr = err as? APIError {
                apiError = apiErr
            } else if let decodErr = err as? DecodingError {
                apiError = APIError(.cannotDecodeRawData,
                                    description: String(describing: decodErr))

                debugPrint(String(describing: decodErr))
            } else {

                apiError = APIError(.badServerResponse,
                                    description: String(describing: err))
            }

            return apiError
        }
    }
}

extension Publisher where Output == (data: Data, response: URLResponse) {
    func mapResponse() -> Publishers.TryMap<Self, Data> {
        tryMap { element in
            guard let httpResponse = element.response as? HTTPURLResponse else {
                throw APIError(.badServerResponse,
                               description: String(decoding: element.data, as: UTF8.self))
            }

            if httpResponse.statusCode == 200 {
                return element.data
            }

            throw APIError(httpResponse.statusCode,
                           description: String(decoding: element.data, as: UTF8.self))

        }
    }
}
