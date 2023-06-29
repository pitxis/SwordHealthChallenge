//
//  BreedsModel.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import Foundation

struct BreedModel: Identifiable, Hashable {
    let id: Int
    let name: String
    let breedGroup: String
    let origin: String
    let imageUrl: String
    var category: String
    var temperament: String
}
