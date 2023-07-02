//
//  File.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//

public enum ScrollState: Equatable {
    public static func == (lhs: ScrollState, rhs: ScrollState) -> Bool {
        switch (lhs, rhs) {
        case (.loaded, .loaded):
            return true
        case (.loadingMore, .loadingMore):
            return true
        case (.error(error: _), .error(error: _)):
            return true
        default:
            return false
        }
    }

    case loaded
    case loadingMore
    case error(error: Error)
}
