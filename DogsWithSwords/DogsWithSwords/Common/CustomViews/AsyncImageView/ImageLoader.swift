//
//  ImageLoader.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import SwiftUI
import Combine

enum ImageLoaderState {
    case loading
    case loaded(UIImage)
    case empty
}

class ImageLoader: ObservableObject {
    @Published var state: ImageLoaderState = .loading

    private let path: String

    private var cancellable: AnyCancellable?

    var requestRepository: RequestRepository

    init(path: String, repository: RequestRepository) {
        self.path = "\(path)"
        self.requestRepository = repository
    }

    deinit {
        cancel()
    }

    func load() {
        self.cancellable = self.requestRepository.getImage(path: path)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                if let img = image {
                    self?.state = .loaded(img)
                } else {
                    self?.state = .empty
                }
            }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
