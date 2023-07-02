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
    let category: String
    let temperament: String
    let referenceImageID: String

    init(from dto: BreedDTO) {
        self.id = dto.id
        self.name = dto.name
        self.breedGroup = dto.breedGroup ?? ""
        self.origin = dto.origin ?? ""
        self.category = "MISSING"
        self.temperament = dto.temperament ?? ""
        self.referenceImageID = dto.referenceImageID ?? ""
    }

    init(id: Int,
         name: String,
         breedGroup: String,
         origin: String,
         referenceImageID: String,
         category: String,
         temperament: String) {
        self.id = id
        self.name = name
        self.breedGroup = breedGroup
        self.origin = origin
        self.referenceImageID = referenceImageID
        self.category = "MISSING"
        self.temperament = temperament
    }


}
