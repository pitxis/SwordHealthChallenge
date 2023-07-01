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
                                   nameSpace: animation,
                                   style: vModel.listTypeObs.type)
                    .environmentObject(selectedObject)
                    .background(.yellow)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0) )
                    .background(.blue)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) )

                }
            })
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle())
            .navigationTitle("Breeds")
            .toolbar {
                Button(action: {
                    vModel.toggleViewType()
                }) {
                    Image(systemName: vModel.listTypeObs.type == .grid ?
                          "line.3.horizontal" :
                            "square.grid.2x2")
                }
                Button(action: {

                    vModel.toggleOrder()
                }) {
                    Image(systemName: vModel.order == .asc ? "arrow.down" : "arrow.up")
                }
            }
        }
    }
}

struct BreedsView_Previews: PreviewProvider {
    @Namespace static var animation

    static var previews: some View {

        BreedsView(breedViewModel: BreedListViewModel(), animation: BreedsView_Previews.animation)
            .environmentObject(SelectedObject())
    }
}

struct ListOrGrid<Content: View>: View {
    @ObservedObject var typeObserver: ListTypeObserver

    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 0)
    ]

    let content: Content

    init(type: ListTypeObserver, @ViewBuilder _ content: () -> Content) {
        self.content = content()
        self.typeObserver = type
    }

    var body: some View {
        ScrollViewReader { scroller in
            if typeObserver.type == .list {
                List {
                    content
                }
                .background(.red)
                .onAppear {
                    scroller.scrollTo(typeObserver.scrollTargetId, anchor: .top)
                }
            } else {
                HStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            content.padding([.leading, .trailing], 4)
                        }
                    }
                    .background(.red)
                    .onAppear {
                        scroller.scrollTo(typeObserver.scrollTargetId, anchor: .top)
                    }
                }
            }
        }
    }
}
