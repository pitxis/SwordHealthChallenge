//
//  SearchBreedsView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct SearchBreedsView<Model>: View where Model: BreedSearchViewModelProtocol {
    @ObservedObject var vModel: Model
    @EnvironmentObject var selectedObject: SelectedObject
    var animation: Namespace.ID

    init(breedSearchViewModel model: Model, nameSpace: Namespace.ID) {
        self.vModel = model
        self.animation = nameSpace
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(vModel.resultsList, id: \.id) { item in
                    Button(action: {
                        self.selectedObject.parent = .breedsSearch
                        self.selectedObject.model = item

                        withAnimation(.interpolatingSpring(stiffness: 300, damping: 20)) {
                            self.selectedObject.isShowing = true

                        }
                    }) {
                        BreedSearchListCell(id: item.id,
                            name: item.name,
                                            group: item.breedGroup,
                                            origin: item.origin,
                        animation: animation)
                        .environmentObject(self.selectedObject)
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .edgesIgnoringSafeArea([.trailing, .leading])
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
            .navigationTitle("Search Breeds")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: self.$vModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct SearchBreedsView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        SearchBreedsView(breedSearchViewModel: BreedSearchViewModel(), nameSpace: namespace)
    }
}
