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

    @EnvironmentObject var selectedObject: SelectedObject

    init(model: BreedModel,
         animation: Namespace.ID) {
        self.model = model
        self.animation = animation
    }

    var imageId: String {
        get {
            switch selectedObject.parent {
            case .breedsList, .none:
                return "list_\(model.id)"
            case .breedsSearch:
                return "search_\(model.id)"
            }
        }
    }

    var body: some View {
        MovableResizableView(isPresented: $selectedObject.isShowing) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Image("CuteDog")
                        .resizable()
                        .scaledToFit()
                        .matchedGeometryEffect(id: self.imageId, in: animation)
                    Button(action: {
                        selectedObject.isShowing = false
                    }, label: {
                        Image(systemName: "rectangle.and.hand.point.up.left.filled")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .padding(8)
                    })
                }
                HStack(spacing: 4) {
                    Text("Name")
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                    Text("Category")
                        .frame(maxWidth: .infinity)
                        .background(.blue)

                }
                HStack(spacing: 4) {
                    Text(model.name)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                    Text(model.category)
                        .frame(maxWidth: .infinity)
                        .background(.blue)

                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))

                HStack(spacing: 4) {
                    Text("Origin")
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                    Text("Temperament")
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                }
                HStack(spacing: 4) {
                    Text(model.origin)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                    Text(model.temperament)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                }

                .frame(maxWidth: .infinity)

            }
            .background(.white)
            .cornerRadius(10)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.9))
        .ignoresSafeArea()
    }
}

struct BreedDetailView_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        BreedDetailView(model: BreedModel(id: 1, name: "A Name",
                                          breedGroup: "Breed Group",
                                          origin: "Origin",
                                          imageUrl: "URL",
                                          category: "Category",
                                          temperament: "Temperament"),
                        animation: namespace)
        .environmentObject(SelectedObject())
    }
}


