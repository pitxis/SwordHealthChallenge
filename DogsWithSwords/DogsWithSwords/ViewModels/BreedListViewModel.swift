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
    var requestService: RequestRepository { get }

    func toggleViewType()
    func toggleOrder()
    func onItemAppear(_ model: BreedModel)
}

class BreedListViewModel: BreedListViewModelProtocol {
    @Published var modelList: [BreedModel] = []
    @Published var listTypeObs: ListTypeObserver = ListTypeObserver()
    @Published var order: ListOrder = .asc

    private var cancellables = Set<AnyCancellable>()

    let requestService: RequestRepository

    init(requestService: RequestRepository) {
        self.requestService = requestService

        self.requestService.networkStatus().sink(receiveValue: { [weak self] status in
            switch status {
                case .undifined:
                break
                default:
                if let lSelf = self {
                    lSelf.getBreeds()
                        .receive(on: DispatchQueue.main)
                        .sink(receiveValue: { val in
                            lSelf.modelList = val
                        })
                        .store(in: &lSelf.cancellables)
                }
            }
        })
        .store(in: &cancellables)
    }

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

    public func onItemAppear(_ model: BreedModel) {
        self.listTypeObs.scrollTargetId = model.id
    }

    private func getBreeds() -> AnyPublisher<[BreedModel], Never> {
        return self.requestService
                        .getBreeds()

            .eraseToAnyPublisher()
    }
}
