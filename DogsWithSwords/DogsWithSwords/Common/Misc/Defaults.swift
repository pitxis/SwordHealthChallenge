//
//  Defaults.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import SwiftUI

struct Defaults {
    static let LIMIT: Int = 20

    static var nameGeometryKey: (Int, DetailViewParent?) -> String = { id, type in
        switch type {
        case .breedsList, .none:
            return "list_\(id)"
        case .breedsSearch:
            return "search_\(id)"
        }
    }

}
