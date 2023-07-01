//
//  AsyncImageView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import SwiftUI

struct AsyncImageView<Placeholder: View, ErrorView: View>: View {
    @StateObject private var loader: ImageLoader

    private let placeholder: Placeholder
    private let errorView: ErrorView
    private let requestService: RequestRepository

    init(imageURL: String,
         requestService: RequestRepository,
         @ViewBuilder placeholder: () -> Placeholder,
         @ViewBuilder errorView: () -> ErrorView) {
        self.placeholder = placeholder()
        self.errorView = errorView()
        self.requestService = requestService

        _loader = StateObject(wrappedValue: ImageLoader(path: imageURL,
                                                        repository: requestService))
    }

    var body: some View {
        content
            .onAppear(perform: loader.load)
    }

    private var content: some View {
        Group {
            switch loader.state {
            case .loading:
                placeholder
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
            case .empty:
                errorView
            }
        }
    }
}
