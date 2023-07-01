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

    @StateObject var selectedObject: SelectedObject = SelectedObject()

    var body: some View {
        TabView {
            BreedsView(breedViewModel: BreedListViewModel(), animation: animation)
                .environmentObject(self.selectedObject)
                .tabItem {
                    Label("List", systemImage: "list.bullet.circle")

                }
            SearchBreedsView(breedSearchViewModel: BreedSearchViewModel(), nameSpace: animation)
                .environmentObject(self.selectedObject)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
        }
        .overlay {
            if self.selectedObject.isShowing,
               let model = self.selectedObject.model {

                BreedDetailView(model: model,
                                animation: animation)
                .environmentObject(selectedObject)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
