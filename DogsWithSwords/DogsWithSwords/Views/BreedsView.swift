//
//  BreedsView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct BreedsView<Model>: View where Model: BreedListViewModelProtocol {
    @ObservedObject var vModel: Model

    init(vModel: Model) {
        self.vModel = vModel
    }

    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]

    var body: some View {
        NavigationView {
            ListOrGrid(type: vModel.listTypeObs, {
                ForEach(vModel.modelList, id: \.id) { item in
                    BreedsListCell(name: item.name, style: vModel.listTypeObs.type)
                        .cornerRadius(10)
                        .listRowSeparator(.hidden)
                }
            })
            .edgesIgnoringSafeArea([.trailing, .leading])
            .scrollContentBackground(.hidden)
            .listStyle(PlainListStyle())
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
    static var previews: some View {
        BreedsView(vModel: BreedListViewModel())
    }
}

struct ListOrGrid<Content: View>: View {
    @ObservedObject var typeObserver: ListTypeObserver

    let columns = [
        GridItem(.adaptive(minimum: 120))
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
                .onAppear {
                    scroller.scrollTo(typeObserver.scrollTargetId, anchor: .top)
                }
            } else {
                HStack {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            content
                        }
                    }
                    .onAppear {
                        scroller.scrollTo(typeObserver.scrollTargetId, anchor: .top)
                    }
                    .padding([.leading, .trailing])
                }
            }
        }
    }
}
