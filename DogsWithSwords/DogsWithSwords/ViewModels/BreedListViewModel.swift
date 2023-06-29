//
//  BreedListViewModel.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import Foundation
import Combine

enum ListType {
    case list
    case grid
}

enum ListOrder {
    case asc
    case desc
}

class ListTypeObserver: ObservableObject {
    @Published var type: ListType = .list
    @Published var scrollTargetId = 0
}

protocol BreedListViewModelProtocol: ObservableObject {
    var modelList: [BreedModel] { get }
    var listTypeObs: ListTypeObserver { get }
    var order: ListOrder { get }

    func toggleViewType()
    func toggleOrder()
}

class BreedListViewModel: BreedListViewModelProtocol {
    @Published var modelList: [BreedModel] = BreedListViewModel.breeds
    @Published var listTypeObs: ListTypeObserver = ListTypeObserver()
    @Published var order: ListOrder = .asc

    func toggleViewType() {
        listTypeObs.type = listTypeObs.type == .grid ? .list : .grid
    }

    func toggleOrder() {
        order = order == .asc ? .desc : .asc

        modelList = modelList.sorted {
            switch order {
            case .asc:
                return $0.name < $1.name
            case .desc:
                return $0.name > $1.name
            }
        }
    }

#if DEBUG
    static let breeds: [BreedModel] = [
        BreedModel(id: 1, name: "A Name",
                   breedGroup: "A BreedGroup",
                   origin: "A Origin",
                   imageUrl: "URL",
                   category: "A category",
                   temperament: "A temperament"),
        BreedModel(id: 2, name: "B Name",
                   breedGroup: "",
                   origin: "",
                   imageUrl: "URL",
                   category: "",
                   temperament: ""),
        BreedModel(id: 3, name: "C Name",
                   breedGroup: "",
                   origin: "",
                   imageUrl: "URL",
                   category: "",
                   temperament: ""),
        BreedModel(id: 4, name: "D Name",
                   breedGroup: "",
                   origin: "",
                   imageUrl: "URL",
                   category: "",
                   temperament: "")
    ]
#endif
}
