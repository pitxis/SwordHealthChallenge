//
//  BreedSearchViewModelTest.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import XCTest
import Combine
@testable import DogsWithSwords

final class BreedSearchViewModelTests: XCTestCase {
    let url = URL(string: "www.DogsAPI.com")!
    var cancellables = Set<AnyCancellable>()

    var session: MockAPISession?
    var imgCacheWrapper: MockCacheWrapper<NSString, UIImage>?
    var imageCache: MockImageCacheService<MockImageCacheType>?
    var dataCacheWrapper: MockCacheWrapper<NSString, NSData>?


    func testSearch() {
        let mock = MockRequestRepository()
        mock.result = [DefaultModels.breedsModel]

        let vModel = BreedSearchViewModel(requestService: mock)
        vModel.searchQuery = "York"

        var result = [BreedModel]()

        let exp = self.expectation(description: "Expect for search debouce")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            vModel.$resultsList.sink(receiveValue: { res in
                result = res
                if res.count > 0 {
                    exp.fulfill()
                }
            }).store(in: &self.cancellables)

        }
        wait(for: [exp], timeout: 25)

        XCTAssertEqual(result, [DefaultModels.breedsModel])
    }
}
