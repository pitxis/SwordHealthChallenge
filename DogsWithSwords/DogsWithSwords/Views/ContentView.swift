//
//  ContentView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

class SelectedObject: ObservableObject {
    @Published var isShowing = false
    var model: BreedModel?
    var parent: DetailViewParent?
}

struct ContentView: View {
    @Namespace var animation

    @StateObject var coordinator: CoordinatorObject = CoordinatorObject()
//    @ObservedObject var networkMonitor: NetworkMonitor = NetworkMonitor()
    @StateObject var selectedObject: SelectedObject = SelectedObject()

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
        }.banner(data: .error("No Internet Cnnection") , show: self.$coordinator.isOffline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: CoordinatorObject())
    }
}
