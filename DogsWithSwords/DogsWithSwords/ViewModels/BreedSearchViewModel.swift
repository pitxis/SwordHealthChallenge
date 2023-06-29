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
    static let breedsResult: [BreedModel] = [
        BreedModel(id: 1,
                   name: "A Name",
                   breedGroup: "A Group",
                   origin: "A Origin",
                   imageUrl: "URL",
                   category: "A Category",
                   temperament: "A temperament"),
        BreedModel(id: 2,
                   name: "B Name",
                   breedGroup: "B Group",
                   origin: "B Origin",
                   imageUrl: "URL",
                   category: "",
                   temperament: ""),
        BreedModel(id: 3,
                   name: "C Name",
                   breedGroup: "C Group",
                   origin: "C Origin",
                   imageUrl: "URL",
                   category: "",
                   temperament: ""),
        BreedModel(id: 4,
                   name: "D Name",
                   breedGroup: "D Group",
                   origin: "D Origin",
                   imageUrl: "URL",
                   category: "",
                   temperament: ""),
    ]

    static let breedsOneResult: [BreedModel] = [
        BreedModel(id: 1, name: "A Name",
                   breedGroup: "A Group",
                   origin: "A Origin",
                   imageUrl: "URL",
                   category: "",
                   temperament: ""),

    ]
#endif
}
