//
//  BreedsListCell.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct BreedsListCell: View {
    let id: Int
    let breedName: String
    let style: ListType
    var animation: Namespace.ID

    @EnvironmentObject var selectedObject: SelectedObject

    init(id: Int, name breedName: String, nameSpace: Namespace.ID, style: ListType = .list) {
        self.breedName = breedName
        self.style = style
        self.id = id
        self.animation = nameSpace
    }

    var body: some View {
        VStack(spacing: 0) {
            Text(breedName)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(id)")

            if !(selectedObject.isShowing && selectedObject.model?.id ?? -1 == id) {
                Image("CuteDog")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.leading, .trailing])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(5)
                    .matchedGeometryEffect(id: "list_\(id)", in: animation)
            } else {
                Image("CuteDog")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea([.leading, .trailing])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cornerRadius(5)
            }
        }
    }
}

struct BreedsListCell_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        BreedsListCell(id: 1, name: "Breed Name", nameSpace: namespace)
            .environmentObject(SelectedObject())
    }
}
