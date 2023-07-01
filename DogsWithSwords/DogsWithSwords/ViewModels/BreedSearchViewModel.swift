//
//  BreedSearchViewModel.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 28/06/2023.
//

import Foundation
import Combine

protocol BreedSearchViewModelProtocol: ObservableObject {
    var searchQuery: String { get set }
    var resultsList: [BreedModel] { get }
}

class BreedSearchViewModel: BreedSearchViewModelProtocol {
    @Published var resultsList: [BreedModel] = BreedSearchViewModel.breedsOneResult
    @Published var searchQuery: String = ""

    let requestService: HttpRequestRepository
    var offset = 0

    var cancellables = Set<AnyCancellable>()

    init() {
        // TODO: DI this
        self.requestService = HttpRequestRepository(httpService: HttpService(session: URLRequestSession()))

        
        self.searchPublisher($searchQuery)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.resultsList = result
            }
            .store(in: &cancellables)
    }


    private func searchPublisher(_ text: Published<String>.Publisher) -> AnyPublisher<[BreedModel], Never> {
        return text.debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { val in
                if val.count > 2 {
                    self.offset = 0
                    return self.requestService.searchBreeds(val, offset: self.offset, limit: 10)
                }

                return Just(self.resultsList).eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

#if DEBUG
    static let breedsResult: [BreedModel] = [
        BreedModel(id: 1,
                   name: "A Name",
                   breedGroup: "A Group",
                   origin: "A Origin",
                   referenceImageID: "URL",
                   category: "A Category",
                   temperament: "A temperament"),
        BreedModel(id: 2,
                   name: "B Name",
                   breedGroup: "B Group",
                   origin: "B Origin",
                   referenceImageID: "URL",
                   category: "",
                   temperament: ""),
        BreedModel(id: 3,
                   name: "C Name",
                   breedGroup: "C Group",
                   origin: "C Origin",
                   referenceImageID: "URL",
                   category: "",
                   temperament: ""),
        BreedModel(id: 4,
                   name: "D Name",
                   breedGroup: "D Group",
                   origin: "D Origin",
                   referenceImageID: "URL",
                   category: "",
                   temperament: ""),
    ]

    static let breedsOneResult: [BreedModel] = [
        BreedModel(id: 1, name: "A Name",
                   breedGroup: "A Group",
                   origin: "A Origin",
                   referenceImageID: "URL",
                   category: "",
                   temperament: ""),

    ]
#endif
}
