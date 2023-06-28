//
//  SearchBreedsView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct SearchBreedsView<Model>: View where Model: BreedSearchViewModelProtocol {
    @ObservedObject var vModel: Model

    init(breedSearchViewModel model: Model) {
        self.vModel = model
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(vModel.resultsList, id: \.id) { item in
                    BreedSearchListCell(name: item.name,
                                        group: item.breedGroup,
                                        origin: item.origin)
                    
                    .listRowSeparator(.hidden)
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
    static var previews: some View {
        SearchBreedsView(breedSearchViewModel: BreedSearchViewModel())
    }
}
