//
//  BreedDTO.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import Foundation

// MARK: - BreedListDTO
typealias BreedListDTO = [BreedDTO]

// MARK: - BreedDTO
struct BreedDTO: Codable {
    let weight, height: Eight
    let id: Int
    let name, lifeSpan: String
    let breedGroup, bredFor, origin, temperament: String?
    let referenceImageID: String?
    let image: BreedImage?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case referenceImageID = "reference_image_id"
        case image
    }
}

// MARK: - Eight
struct Eight: Codable {
    let imperial, metric: String
}

// MARK: - BreedImage
struct BreedImage: Codable {
    let id: String
    let width, height: Int
    let url: String
}
