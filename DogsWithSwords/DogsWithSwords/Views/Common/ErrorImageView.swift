//
//  ErrorImageView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//

import SwiftUI

struct ErrorImageView: View {
    var body: some View {
        Image.errorImage
            .resizable()
            .scaledToFill()
            .clipped()
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ErrorImageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorImageView()
    }
}
