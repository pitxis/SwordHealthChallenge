//
//  BreedsListCell.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

struct BreedsListCell: View {
    let model: BreedModel
    let style: ListType
    var animation: Namespace.ID

    let requestService: RequestRepository

    @EnvironmentObject var selectedObject: SelectedObject

    init(model: BreedModel, nameSpace: Namespace.ID, style: ListType = .list, requestService: RequestRepository) {
        self.model = model
        self.style = style
        self.animation = nameSpace
        self.requestService = requestService
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(model.name)
                .dogFont(self.style == .list ? .title : .body)
                .foregroundColor(.text)
                .lineLimit(self.style == .list ? 1 : 2, reservesSpace: true)
                .frame(maxWidth: .infinity, alignment: .leadingLastTextBaseline)
                .minimumScaleFactor(0.7)
                .padding([.leading], self.style == .list ? 16 : 8)
                .padding([.bottom], 16)

            if selectedObject.isShowing &&
                self.selectedObject.model!.id  == model.id {
                Rectangle().fill(.black.opacity(0.01))
                    .frame(width: self.style == .list ?
                           UIScreen.main.bounds.width :
                            (UIScreen.main.bounds.width - 16) / 3,
                           height: self.style == .list ?
                           UIScreen.main.bounds.width * (3/5) :
                            (UIScreen.main.bounds.width - 16) / 3)
            } else {
                AsyncImageView(imageURL: model.referenceImageID,
                               requestService: self.requestService,
                               placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .frame(maxWidth: self.style == .list ?
                               UIScreen.main.bounds.width :
                                (UIScreen.main.bounds.width - 16) / 3,
                               maxHeight: self.style == .list ?
                               UIScreen.main.bounds.width * (3/5) :
                                (UIScreen.main.bounds.width - 16) / 3)
                },
                               errorView: {
                    ErrorImageView()
                        .frame(maxWidth: self.style == .list ?
                               UIScreen.main.bounds.width :
                                (UIScreen.main.bounds.width - 16) / 3,
                               maxHeight: self.style == .list ?
                               UIScreen.main.bounds.width * (3/5) :
                                (UIScreen.main.bounds.width - 16) / 3)
                        
                })

                .matchedGeometryEffect(id: Defaults.nameGeometryKey(model.id, .breedsList), in: animation, isSource: false)
                .scaledToFill()
                .frame(maxWidth: self.style == .list ?
                       UIScreen.main.bounds.width :
                        (UIScreen.main.bounds.width - 16) / 3,
                       maxHeight: self.style == .list ?
                       UIScreen.main.bounds.width * (3/5) :
                        (UIScreen.main.bounds.width - 16) / 3)
                .clipped()
                .ignoresSafeArea(.all, edges: .all)
            }

        }
        .onTapGesture {
            self.selectedObject.model = model
            self.selectedObject.parent = .breedsList
            withAnimation(.easeIn(duration: 0.25)) {
                self.selectedObject.isShowing = true
            }
        }
    }
}

struct BreedsListCell_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        BreedsListCell(model: BreedModel(id: 1,
                                         name: "Name",
                                         breedGroup: "breedGroup",
                                         origin: "Origin",
                                         referenceImageID: "Image id",
                                         category: "Category",
                                         temperament: "Temperament"),
                       nameSpace: namespace,
                       requestService: DIContainer.httpRequestRepository)
        .environmentObject(SelectedObject())
    }
}
