//
//  RequestBuilder.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import Foundation

public enum RequestError: Error {
    case internalError
    case serverError
    case noInternet
    case unknown

    static func convert(code: URLError.Code) -> RequestError {
        switch code {
        case .badServerResponse:
            return .serverError
        case .notConnectedToInternet:
            return .noInternet
        default:
            return .unknown
        }
    }
}

protocol HttpRequestHeaderProtocol {
    func getURLRequest() -> URLRequest?
}

struct HttpRequestHeader: HttpRequestHeaderProtocol {
    func getURLRequest() -> URLRequest? {
        return request
    }

    var request: URLRequest?
    var httpError: RequestError?
}

public struct RequestBuilder {

    static func setupGet(_ url: URL?) -> HttpRequestHeader {
        RequestBuilder.setupGet(url, query: nil, limit: -1)
    }

    static func setupGet(_ url: URL?,
                         query: String?,
                         limit: Int = Defaults.LIMIT,
                         page: Int = 0) -> HttpRequestHeader {

        guard var lUrl = url else {
            return HttpRequestHeader(httpError: .internalError)
        }

        lUrl.append(queryItems: [
            URLQueryItem(name: "page", value: String(page)),
        ])

        if limit > 0 {
            lUrl.append(queryItems: [
                URLQueryItem(name: "limit", value: String(limit))
            ])
        }

        if let query = query {
            lUrl.append(queryItems: [
                URLQueryItem(name: "q", value: query),
            ])
        }

        var request = URLRequest(url: lUrl)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(API.pubKey, forHTTPHeaderField: "x-api-key")

        return HttpRequestHeader(request: request)
    }
}
