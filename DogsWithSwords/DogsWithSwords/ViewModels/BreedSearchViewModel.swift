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
    var requestService: RequestRepository { get }
    var showBanner: Bool { get set }
    var bannerType: BannerType { get }

    func onItemAppear(_ model: BreedModel)
}

class BreedSearchViewModel: BreedSearchViewModelProtocol {
    @Published var resultsList: [BreedModel] = []
    @Published var searchQuery: String = ""
    @Published var state: ScrollState = .loaded
    @Published var showBanner: Bool = false
    @Published var bannerType: BannerType = .info("")

    let requestService: RequestRepository
    private var page = 0

    private var cancellables = Set<AnyCancellable>()
    private var cancellable: AnyCancellable?

    private var canLoadMore: Bool = false

    init(requestService: RequestRepository) {
        self.requestService = requestService

        self.searchPublisher($searchQuery)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.canLoadMore = result.count == Defaults.LIMIT
                self?.resultsList = result
            }
            .store(in: &cancellables)
    }

    private func searchPublisher(_ text: Published<String>.Publisher) -> AnyPublisher<[BreedModel], Never> {
        return text.debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { val in
                if val.count > 2 {
                    self.page = 0
                    return self.requestService
                        .searchBreeds(val, page: self.page, limit: Defaults.LIMIT)
                }

                self.page = 0
                return Just([]).eraseToAnyPublisher()
            }
            .switchToLatest()
            .eraseToAnyPublisher()
    }

    public func onItemAppear(_ model: BreedModel) {
        if !canLoadMore {
            return
        }

        if state == .loadingMore {
            return
        }

        guard let index = resultsList.firstIndex(where: { $0.id == model.id }) else {
            return
        }

        let thresholdIndex = max(0, resultsList.index(resultsList.endIndex, offsetBy: -2))
        if index != thresholdIndex {
            return
        }

        state = .loadingMore
        cancellable?.cancel()
        cancellable = self.requestService
            .searchBreeds(self.searchQuery, page: self.page, limit: Defaults.LIMIT)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] res in
                self?.state = .loaded
                self?.page += 1
                self?.canLoadMore = res.count == Defaults.LIMIT
                self?.resultsList += res
            }
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
