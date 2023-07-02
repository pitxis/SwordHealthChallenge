//
//  BreedDetailView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 28/06/2023.
//

import SwiftUI

enum DetailViewParent {
    case breedsList
    case breedsSearch
}

struct BreedDetailView: View {
    var animation: Namespace.ID
    var model: BreedModel

    let requestService: RequestRepository

    @EnvironmentObject var selectedObject: SelectedObject

    init(model: BreedModel,
         animation: Namespace.ID,
         requestService: RequestRepository) {
        self.model = model
        self.animation = animation
        self.requestService = requestService
    }

    var body: some View {
        MovableResizableView(isPresented: $selectedObject.isShowing) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    AsyncImageView(imageURL: self.model.referenceImageID,
                                   requestService: self.requestService,
                                   placeholder: {

                        GeometryReader { geo in
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        }
                    }, errorView: {
                        ErrorImageView()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)

                    })
                    .matchedGeometryEffect(id: Defaults.nameGeometryKey(model.id, selectedObject.parent), in: animation)
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 2)
                    .clipped()

                    Button(action: {
                        selectedObject.isShowing = false
                    }, label: {
                        Image(systemName: "rectangle.and.hand.point.up.left.filled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .padding(8)
                    })
                    .foregroundColor(.accent)
                }
                HStack(spacing: 4) {
                    Text(AppStrings.name)
                        .dogFont(.subtitle)
                        .frame(maxWidth: .infinity)

                    Text(AppStrings.origin)
                        .dogFont(.subtitle)
                        .frame(maxWidth: .infinity)
                }
                HStack(spacing: 4) {
                    Text(model.name)
                        .dogFont(.body)
                        .foregroundColor(.text)
                        .frame(maxWidth: .infinity)

                    Text(model.origin)
                        .dogFont(.body)
                        .foregroundColor(.text)
                        .frame(maxWidth: .infinity)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))

                Text(AppStrings.temperament)
                    .dogFont(.subtitle)
                    .frame(maxWidth: .infinity)

                Text(model.temperament)
                    .dogFont(.body)
                    .foregroundColor(.text)
                    .frame(maxWidth: .infinity)
                    .padding([.leading, .bottom, .trailing], 16)
            }
            .background(Color.detail)
            .cornerRadius(5)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.opacity(0.95))
    }
}

struct BreedDetailView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        BreedDetailView(model: BreedModel(id: 1, name: "A Name",
                                          breedGroup: "Breed Group",
                                          origin: "Origin",
                                          referenceImageID: "URL",
                                          category: "Category",
                                          temperament: "Temperament"),
                        animation: namespace,
                        requestService: DIContainer.httpRequestRepository)
        .environmentObject(SelectedObject())
    }
}
