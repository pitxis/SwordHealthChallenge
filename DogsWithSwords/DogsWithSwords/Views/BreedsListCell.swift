//
//  BreedsListCell.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct BreedsListCell: View {
    let breedName: String
    let style: ListType

    init(name breedName: String, style: ListType = .list) {
        self.breedName = breedName
        self.style = style
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Image("CuteDog")
                .resizable()
                .scaledToFit()
            VStack {

                ZStack(alignment: .leading) {
                    Rectangle().foregroundColor(.black.opacity(0.4)).frame(height: style == .list ? 50 : 20)
                    Text(breedName)
                        .foregroundColor(.white)
                        .padding(8)
                }
            }
        }
    }
}

struct BreedsListCell_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListCell(name: "Breed Name")
    }
}
