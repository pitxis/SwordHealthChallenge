//
//  BreedSearchListCell.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 28/06/2023.
//

import SwiftUI

struct BreedSearchListCell: View {
    let model: BreedModel
    var animation: Namespace.ID

    @EnvironmentObject var selectedObject: SelectedObject

    let requestService: RequestRepository

    init(model: BreedModel,
         animation: Namespace.ID,
         requestService: RequestRepository) {
        self.model = model
        self.animation = animation
        self.requestService = requestService
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if selectedObject.isShowing &&
                self.selectedObject.model!.id  == model.id {
                Rectangle().fill(.black.opacity(1))
                    .frame(width: 100, height: 100)

            } else {
                AsyncImageView(imageURL: self.model.referenceImageID,
                               requestService: self.requestService,
                               placeholder: {
                    GeometryReader { geo in
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .frame(width: geo.size.width, height: geo.size.width / 3)
                    }
                },
                               errorView: {
                    ErrorImageView()
                        .frame(width: 100, height: 100)

                })
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .clipped()
                .matchedGeometryEffect(id: Defaults.nameGeometryKey(model.id, .breedsSearch),
                                       in: animation,
                                       isSource: false)
            }
            VStack(alignment: .listRowSeparatorLeading){
                Text(AppStrings.name)
                    .dogFont(.subtitle)
                Text(self.model.name)
                    .dogFont(.body)
                    .foregroundColor(.text)
                    .padding([.bottom], 4)
                Text(AppStrings.group)
                    .dogFont(.subtitle)
                Text(self.model.breedGroup)
                    .dogFont(.body)
                    .foregroundColor(.text)
                    .padding([.bottom], 4)

                Text(AppStrings.origin)
                    .dogFont(.subtitle)
                Text(self.model.origin)
                    .dogFont(.body)
                    .foregroundColor(.text)
            }

            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.detail)
        .onTapGesture {
            self.selectedObject.model = model
            self.selectedObject.parent = .breedsSearch
            withAnimation(.easeIn(duration: 0.25)) {
                self.selectedObject.isShowing = true
            }
        }
    }
}

struct BreedSearchListCell_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        BreedSearchListCell(model: BreedModel(id: 1,
                                              name: "A Name",
                                              breedGroup: "A BreedGroup",
                                              origin: "A Origin",
                                              referenceImageID: "URL",
                                              category: "A category",
                                              temperament: "A temperament"),
                            animation: namespace,
                            requestService: DIContainer.httpRequestRepository)
        .environmentObject(SelectedObject())
    }
}
