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

    let requestService: HttpRequestRepository

    @EnvironmentObject var selectedObject: SelectedObject

    init(model: BreedModel,
         animation: Namespace.ID) {
        self.model = model
        self.animation = animation

        // TODO: DI this
        self.requestService = HttpRequestRepository(httpService: HttpService(session: URLRequestSession()))
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
                    AsyncImageView(imageURL: self.model.referenceImageID,
                                   requestService: self.requestService,
                                   placeholder: {

                        GeometryReader { geo in
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()

                        }
                    }, errorView: {
                        Image("CuteDog")
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                            .clipped()
                    })
                    .matchedGeometryEffect(id: self.imageId, in: animation)
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
                                          referenceImageID: "URL",
                                          category: "Category",
                                          temperament: "Temperament"),
                        animation: namespace)
        .environmentObject(SelectedObject())
    }
}


