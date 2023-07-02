//
//  SearchBreedsView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct SearchBreedsView<Model>: View where Model: BreedSearchViewModelProtocol {
    @StateObject var vModel: Model
    @EnvironmentObject var selectedObject: SelectedObject
    var animation: Namespace.ID

    init(breedSearchViewModel model: Model, nameSpace: Namespace.ID) {
        self._vModel = StateObject(wrappedValue: model)
        self.animation = nameSpace
    }

    var body: some View {
        NavigationView {
            ZStack {
                if vModel.resultsList.count == 0 {
                    Text(AppStrings.searchNoResults)
                        .dogFont(.subtitle)
                        .foregroundColor(.text)
                }
                else {
                    List {
                        ForEach(vModel.resultsList, id: \.id) { item in
                            BreedSearchListCell(model: item,
                                                animation: animation,
                                                requestService: vModel.requestService
                            )
                            .environmentObject(self.selectedObject)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 4, trailing: 16) )
                            .background(Color.background)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) )
                            .onAppear(perform: {
                                self.vModel.onItemAppear(item)
                            })
                        }
                    }

                    .scrollContentBackground(.hidden)
                    .listStyle(GroupedListStyle())
                    .background(Color.background)
                }
            }
            .navigationTitle(AppStrings.searchBreeds)
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: self.$vModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
            .banner(data: self.vModel.bannerType, show: self.$vModel.showBanner)
        }
    }
}

struct SearchBreedsView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        SearchBreedsView(breedSearchViewModel: BreedSearchViewModel(requestService: DIContainer.httpRequestRepository),
                         nameSpace: namespace)
        .environmentObject(SelectedObject())
    }
}
