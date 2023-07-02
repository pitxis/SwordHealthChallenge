//
//  MarvellousFont.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//

import Foundation
import SwiftUI

struct DogFont: ViewModifier {

    @Environment(\.sizeCategory) var sizeCategory

    public enum TextStyle {
        case title
        case subtitle
        case body
    }

    var textStyle: TextStyle

    func body(content: Content) -> some View {
        return content.font(.system(size: size, weight: weight, design: .rounded))
    }

    private var weight: Font.Weight {
        switch textStyle {
        case .title:
            return .bold
        case .body:
            return .medium
        case .subtitle:
            return .semibold

        }
    }

    private var size: CGFloat {
        switch textStyle {
        case .title:
            return 24
        case .subtitle:
            return 20
        case .body:
            return 18
        }
    }
}

extension View {
    func dogFont(_ textStyle: DogFont.TextStyle) -> some View {
        self.modifier(DogFont(textStyle: textStyle))
    }
}
