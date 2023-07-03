//
//  HttpRequestRepo.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import XCTest
import Combine
@testable import DogsWithSwords

final class HttpRequestTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    let url = URL(string: "www.DogsAPI.com")!

    var session: MockAPISession?
    var imgCacheWrapper: MockCacheWrapper<NSString, UIImage>?
    var imageCache: MockImageCacheService<MockImageCacheType>?
    var dataCacheWrapper: MockDataCacheType?
    var httpService: HttpServiceMock?
    var dataCache: MockDataCacheService<MockDataCacheType>?
    var networkMonitor: MockNetworkMonitor?
    var storeService: MockStoreService?


    override func setUp() async throws {
        self.httpService = HttpServiceMock()
        self.imgCacheWrapper = MockImageCacheType()
        self.imageCache = MockImageCacheService<MockImageCacheType>(cache: imgCacheWrapper!)
        self.dataCacheWrapper = MockDataCacheType()
        self.dataCache = MockDataCacheService<MockDataCacheType>(cache: dataCacheWrapper!)
        self.networkMonitor = MockNetworkMonitor()
        self.storeService = MockStoreService()
    }

    func testGetImageOk() throws {
        let httpService = HttpServiceMock()
        httpService.data = TestStrings.imageSearchOkString.data(using: .utf8)!
        let request = HttpRequestRepository(httpService: httpService,
                                            imageCache: imageCache!,
                                            dataCache: dataCache!,
                                            networkMonitor: networkMonitor!,
                                            storeService: storeService!)


        let exp = self.expectation(description: "Load image")

        var result: UIImage?
        request.getImage(path: "Path")
            .sink(receiveCompletion: { _ in
                exp.fulfill()
            }, receiveValue: { result = $0 })
            .store(in: &cancellables)

        wait(for: [exp], timeout: 25)

        XCTAssertNotNil(result)
    }

    func testGetImageBadURL() throws {
        let httpService = HttpServiceMock()
        let request = HttpRequestRepository(httpService: httpService,
                                            imageCache: imageCache!,
                                            dataCache: dataCache!,
                                            networkMonitor: networkMonitor!,
                                            storeService: storeService!)

        let exp = self.expectation(description: "Load image")

        var result: UIImage?
        request.getImage(path: "")

            .sink(receiveCompletion: { _ in
                exp.fulfill()
            }, receiveValue: { result = $0 })
            .store(in: &cancellables)

        wait(for: [exp], timeout: 25)

        XCTAssertNil(result)
    }

    func testGetImageError() throws {
        let httpService = HttpServiceMock()
        let request = HttpRequestRepository(httpService: httpService,
                                            imageCache: imageCache!,
                                            dataCache: dataCache!,
                                            networkMonitor: networkMonitor!,
                                            storeService: storeService!)

        httpService.image = nil

        let exp = self.expectation(description: "Load image")

        var result: UIImage?
        request.getImage(path: "Path")
            .sink(receiveCompletion: { _ in
                exp.fulfill()
            }, receiveValue: { result = $0 })
            .store(in: &cancellables)

        wait(for: [exp], timeout: 25)

        XCTAssertNil(result)
    }

    func testGetBreeds() throws {
        let httpService = HttpServiceMock()
        httpService.data = TestStrings.breedOkString.data(using: .utf8)!

        let request = HttpRequestRepository(httpService: httpService,
                                            imageCache: imageCache!,
                                            dataCache: dataCache!,
                                            networkMonitor: networkMonitor!,
                                            storeService: storeService!)

        let exp = self.expectation(description: "Breed Detail")

        var result: [BreedModel]?
        request.getBreeds()
            .sink(receiveCompletion: { _ in
                exp.fulfill()
            }, receiveValue: { result = $0 })
            .store(in: &cancellables)

        wait(for: [exp], timeout: 25)

        XCTAssertEqual(result![0].name, "Affenpinscher")
    }

    func testSearchBreeds() throws {
        let httpService = HttpServiceMock()
        httpService.data = TestStrings.searchOkString.data(using: .utf8)!

        let request = HttpRequestRepository(httpService: httpService,
                                            imageCache: imageCache!,
                                            dataCache: dataCache!,
                                            networkMonitor: networkMonitor!,
                                            storeService: storeService!)

        let exp = self.expectation(description: "Breed Search Details")

        var result: [BreedModel]?
        request.searchBreeds("Yorkshire", page: 0, limit: 10)
            .sink(receiveCompletion: { _ in
                exp.fulfill()
            }, receiveValue: {
                result = $0
            })
            .store(in: &cancellables)

        wait(for: [exp], timeout: 25)

        XCTAssertEqual(result!.first!.name, "Yorkipoo")
    }

}

