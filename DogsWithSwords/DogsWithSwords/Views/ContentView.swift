//
//  ContentView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI
import Combine

class SelectedObject: ObservableObject {
    @Published var isShowing = false
    var model: BreedModel?
    var parent: DetailViewParent?
}

class ContentViewModel: ObservableObject {
    @Published var isOffline: Bool = true
    @Published var networkMonitor: NetworkMonitor

    var cancellables = Set<AnyCancellable>()

    init(networkMonitor: NetworkMonitor) {
        self.networkMonitor = networkMonitor

        self.networkMonitor
            .isOffline()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] val in
                self?.isOffline = val == .offline
               }).store(in: &cancellables)
    }
}

struct ContentView: View {
    @Namespace var animation

    @StateObject var selectedObject: SelectedObject = SelectedObject()
    @StateObject var coordinator: CoordinatorObject

    @StateObject var vModel: ContentViewModel

    init(contentViewModel: ContentViewModel, coordinator: CoordinatorObject) {
        self._vModel = StateObject(wrappedValue: contentViewModel)
        self._coordinator = StateObject(wrappedValue: coordinator)
    }

    var body: some View {
        TabView {
            coordinator.getBreedListView(animation: animation)

                .environmentObject(self.selectedObject)
                .tabItem {
                    Label(AppStrings.list, systemImage: "list.bullet.circle")


                }
                
            coordinator.getBreedSearchView(animation: animation)
                .environmentObject(self.selectedObject)
                .tabItem {
                    Label(AppStrings.search, systemImage: "magnifyingglass.circle")
                }
        }
        .overlay {

            if self.selectedObject.isShowing,
               let model = self.selectedObject.model {
                coordinator.getBreedDetailView(model: model, animation: animation)
                    .environmentObject(selectedObject)
            }
        }.banner(data: .error("No Internet Cnnection"),
                 show: self.$vModel.isOffline,
                 dismissable: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let networkMonitor = NetworkMonitor()
    static var previews: some View {
        ContentView(contentViewModel: ContentViewModel(networkMonitor: networkMonitor),
                    coordinator: CoordinatorObject(networkMonitor: networkMonitor))
    }
}
