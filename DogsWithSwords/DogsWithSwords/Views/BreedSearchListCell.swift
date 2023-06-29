//
//  BreedSearchListCell.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 28/06/2023.
//

import SwiftUI

struct BreedSearchListCell: View {
    let id: Int
    let name: String
    let breedGroup: String
    let origin: String
    var animation: Namespace.ID

    init(id: Int, name breedName: String,
         group breedGroup: String,
         origin: String, animation: Namespace.ID) {
        self.name = breedName
        self.breedGroup = breedGroup
        self.origin = origin
        self.id = id
        self.animation = animation
    }

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image("CuteDog")
                .resizable()
                .cornerRadius(40)
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "search_\(id)", in: animation)

            VStack(alignment: .leading){
                Text("Name:")

                Text(self.name)
                Text("Group:")
                Text(self.breedGroup)
                Text("Origin:")
                Text(self.origin)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.blue)

            Image(systemName: "oval")

        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.red)
        .cornerRadius(10)

    }
}

struct BreedSearchListCell_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        BreedSearchListCell(id: 1, name: "Breed Name", group: "Group", origin: "Origin", animation: namespace)
    }
}
