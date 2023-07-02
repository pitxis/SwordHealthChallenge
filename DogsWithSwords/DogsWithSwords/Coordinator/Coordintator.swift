//
//  Coordintator.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//

import SwiftUI
import Combine

class CoordinatorObject: ObservableObject {
    @Published var breedListViewModel: BreedListViewModel!
    @Published var searchViewModel: BreedSearchViewModel!
    @Published var isOffline: Bool = false

    var networkMonitor: NetworkMonitor = NetworkMonitor()

    let requestService: RequestRepository
    var cancellables = Set<AnyCancellable>()

    init() {
        self.requestService = DIContainer.httpRequestRepository
        self.breedListViewModel = BreedListViewModel(requestService: requestService)
        self.searchViewModel = BreedSearchViewModel(requestService: requestService)
        self.networkMonitor.$isOffline.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] val in
            print(val)
            self?.isOffline = val
        }).store(in: &cancellables)
    }

    func getBreedListView(animation: Namespace.ID) -> AnyView? {
        AnyView(_fromValue:
                    BreedsView(
                        breedViewModel: self.breedListViewModel,
                        animation: animation)
        )
    }

    func getBreedSearchView(animation: Namespace.ID) -> AnyView? {
        AnyView(_fromValue:
                    SearchBreedsView(
                        breedSearchViewModel: self.searchViewModel,
                        nameSpace: animation)
        )
    }

    func getBreedDetailView(model: BreedModel, animation: Namespace.ID) -> some View {
        return BreedDetailView(model: model,
                               animation: animation, requestService: self.requestService)

    }
}
