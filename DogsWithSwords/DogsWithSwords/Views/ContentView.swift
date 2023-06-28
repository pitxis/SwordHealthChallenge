//
//  ContentView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BreedsView(vModel: BreedListViewModel())
                .tabItem {
                    Label("List", systemImage: "list.bullet.circle")

                }
            SearchBreedsView(breedSearchViewModel: BreedSearchViewModel())
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
