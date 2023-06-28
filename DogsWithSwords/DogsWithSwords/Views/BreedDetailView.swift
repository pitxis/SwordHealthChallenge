//
//  BreedDetailView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 28/06/2023.
//

import SwiftUI

struct BreedDetailView: View {
    var name: String
    var category: String
    var origin: String
    var temperament: String

    var body: some View {
        VStack {
            Image("CuteDog")
                .resizable()
                .scaledToFit()
            Text(self.name)
            Text(self.category)
            Text(self.origin)
            Text(self.temperament)

        }
        .background(.red)
        .ignoresSafeArea()
    }
}

struct BreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailView(name: "Breed 1", category: "Category 1", origin: "Origin 1", temperament: "Temperament 1")
    }
}
