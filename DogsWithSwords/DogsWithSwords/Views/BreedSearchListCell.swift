//
//  BreedSearchListCell.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 28/06/2023.
//

import SwiftUI

struct BreedSearchListCell: View {
    let name: String
    let breedGroup: String
    let origin: String

    init(name breedName: String,
         group breedGroup: String,
         origin: String) {
        self.name = breedName
        self.breedGroup = breedGroup
        self.origin = origin
    }

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image("CuteDog")
                .resizable()
                .cornerRadius(40)
                .frame(width: 80, height: 80)
                .aspectRatio(contentMode: .fill)

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
    static var previews: some View {
        BreedSearchListCell(name: "Breed Name", group: "Group", origin: "Origin" )
    }
}
