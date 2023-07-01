//
//  HttpServiceTests.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 30/06/2023.
//

import XCTest
import Combine
@testable import DogsWithSwords

final class HttpServiceTests: XCTestCase {
    let url = URL(string: "www.DogsAPI.com")!
    var cancellables = Set<AnyCancellable>()

    var session: MockAPISession?
    var imgCacheWrapper: MockCacheWrapper<NSString, UIImage>?
    var imageCache: MockImageCacheService<MockImageCacheType>?
    var dataCacheWrapper: MockCacheWrapper<NSString, NSData>?


    override func setUp() async throws {
        self.session = MockAPISession()
        self.imgCacheWrapper = MockCacheWrapper<NSString, UIImage>()
        self.imageCache = MockImageCacheService<MockImageCacheType>(cache: imgCacheWrapper!)
        self.dataCacheWrapper = MockCacheWrapper<NSString, NSData>()
    }

    func testOkGetRequest() throws {
        let service = HttpService(session: session!,
                                  imageCache: imageCache!)

        session!.data = TestStrings.breedOkString.data(using: .utf8)!

        var value: Data = Data()

        service.get(URLRequest(url: url))
            .sink { completion in
                guard case .finished = completion else { return }
            } receiveValue: {
                value = $0
            }.store(in: &cancellables)

        XCTAssertEqual(String(decoding: value, as: UTF8.self), TestStrings.breedOkString)
    }

    func test400Response() throws {
        let service = HttpService(session: session!,
                                  imageCache: imageCache!)

        session!.data = TestStrings.responseErrorString.data(using: .utf8)!
        session!.response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "", headerFields: [:])!

        let exp = self.expectation(description: "Publishes data then finishes")
        var error: APIError?

        service.get(URLRequest(url: url))
            .sink { completion in
                guard case .failure(let err) = completion else { return }
                error = err
                exp.fulfill()
            } receiveValue: { _ in
                exp.fulfill()
            }.store(in: &cancellables)

        wait(for: [exp], timeout: 25)

        let expected = APIError(URLError(URLError.Code(rawValue: 400)))
        XCTAssertEqual(error!.errorType, expected.errorType)
    }

    func testFailedResponse() throws {
        let service = HttpService(session: session!,
                                  imageCache: imageCache!)

        session!.error = URLError(.badServerResponse)

        let expectation = XCTestExpectation(description: "Publishes data then finishes")
        var error: APIError?

        service.get(URLRequest(url: url))
            .sink { completion in
                guard case .failure(let err) = completion else { return }
                error = err
                expectation.fulfill()
            } receiveValue: { _ in

            }.store(in: &cancellables)

        let expected = APIError(URLError(.badServerResponse))
        XCTAssertEqual(error!.errorType, expected.errorType)
    }

    func testFetchImage() {
        let service = HttpService(session: session!,
                                  imageCache: imageCache!)

        let exp = self.expectation(description: "Publishes Image then finishes")
        let data = (UIImage(systemName: "square.and.arrow.up")?.pngData())!
        session?.data = data
        var resultImg: UIImage?

        service.fetch(imageURL: url)
            .sink { completion in

        } receiveValue: { data in
            resultImg = data
            exp.fulfill()
        }.store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(resultImg)
        XCTAssertNotNil(self.imageCache?.get(for: url))
    }

    func testErrorFetchImage() {
        let service = HttpService(session: session!,
                                  imageCache: imageCache!)

        let exp = self.expectation(description: "Publishes Image then finishes")
        var error: APIError?

        service.fetch(imageURL: url)
            .sink { completion in
            guard case .failure(let err) = completion else {
                return
            }
            error = err
                exp.fulfill()
        } receiveValue: { val in
            print(val)
        }.store(in: &cancellables)

        waitForExpectations(timeout: 5, handler: nil)

        let expected = APIError(URLError(.cannotDecodeRawData))
        XCTAssertEqual(error!.errorType, expected.errorType)
    }
}
