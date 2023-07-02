//
//  BreedsView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct BreedsView<Model>: View where Model: BreedListViewModelProtocol {
    @StateObject var vModel: Model
    @EnvironmentObject var selectedObject: SelectedObject

    var animation: Namespace.ID

    init(breedViewModel: Model, animation: Namespace.ID) {
        self._vModel = StateObject(wrappedValue: breedViewModel)
        self.animation = animation
    }

    var body: some View {
        NavigationView {
            ListOrGrid(type: vModel.listTypeObs, {
                ForEach(vModel.modelList, id: \.id) { item in
                    BreedsListCell(model: item,
                                   nameSpace: self.animation,
                                   style: self.vModel.listTypeObs.type,
                                   requestService: self.vModel.requestService)
                    .environmentObject(selectedObject)
                    .background(Color.background)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0) )
                    .background(Color.detail)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) )
                    .onAppear(perform: {
                        self.vModel.onItemAppear(item)
                    })
                }
            })
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle())
            .navigationTitle(AppStrings.breeds)
            .toolbar {
                Button(action: {
                    vModel.toggleViewType()
                }) {
                    Image(systemName: vModel.listTypeObs.type == .grid ?
                          "line.3.horizontal" :
                            "square.grid.2x2")
                    .foregroundColor(.accent)
                }
                Button(action: {
                    vModel.toggleOrder()
                }) {
                    Image(systemName: vModel.order == .asc ? "arrow.down" : "arrow.up")
                        .foregroundColor(.accent)
                }
            }
        }
    }
}

struct BreedsView_Previews: PreviewProvider {
    @Namespace static var animation

    static var previews: some View {

        BreedsView(breedViewModel: BreedListViewModel(requestService: DIContainer.httpRequestRepository),
                   animation: BreedsView_Previews.animation)
            .environmentObject(SelectedObject())
    }
}
