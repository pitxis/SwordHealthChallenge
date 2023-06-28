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
    var resultsList: [BreedSearchModel] { get }
}

class BreedSearchViewModel: BreedSearchViewModelProtocol {
    @Published var resultsList: [BreedSearchModel] = BreedSearchViewModel.breedsOneResult
    @Published var searchQuery: String = "A"

    var cancellables = Set<AnyCancellable>()


    init() {

        self.$searchQuery
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] query in
            self?.resultsList = BreedSearchViewModel.breedsResult.filter { $0.name.contains(query) }
        })
        .store(in: &cancellables)
    }


#if DEBUG
    static let breedsResult: [BreedSearchModel] = [
        BreedSearchModel(id: 1, name: "A Name", breedGroup: "A Group", origin: "A Origin"),
        BreedSearchModel(id: 2, name: "B Name", breedGroup: "B Group", origin: "B Origin"),
        BreedSearchModel(id: 3, name: "C Name", breedGroup: "C Group", origin: "C Origin"),
        BreedSearchModel(id: 4, name: "D Name", breedGroup: "D Group", origin: "D Origin"),
    ]

    static let breedsOneResult: [BreedSearchModel] = [
        BreedSearchModel(id: 1, name: "A Name", breedGroup: "A Group", origin: "A Origin"),

    ]
#endif
}
