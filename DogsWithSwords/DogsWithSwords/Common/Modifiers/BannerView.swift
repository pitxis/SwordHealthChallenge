//
//  BannerView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//

import Foundation
import SwiftUI
import Combine

enum BannerType {
    case warning(String)
    case info(String)
    case error(String)

    var description: String {
        switch self {
        case .info(let value):
            return value
        case .warning(let value):
            return value
        case .error(let value):
            return value
        }
    }

    var tintColor: Color {
        switch self {
        case .info:
            return Color(red: 67/255, green: 154/255, blue: 215/255)
        case .warning:
            return Color.yellow
        case .error:
            return Color.red
        }
    }

    var title: String {
        switch self {
        case .info:
            return AppStrings.weInform
        case .warning:
            return AppStrings.weWarn
        case .error:
            return AppStrings.weError
        }
    }
}

struct BannerModifier: ViewModifier {
    @State var data: BannerType
    @Binding var show: Bool
    var dismissable: Bool

    init(data: BannerType, show: Binding<Bool>, dismissable: Bool = false) {
        self.data = data
        self._show = show
        self.dismissable = dismissable
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                VStack {
                    Spacer()
                    HStack {
                        Image.defaultImage
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.description)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.tintColor)
                    .cornerRadius(8)
                }
                .padding([.bottom], 100)
                .padding([.horizontal], 12)
                .animation(.easeIn, value: show)
                .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear(perform: {
                    if dismissable {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.show = false
                            }
                        }
                    }
                })
            }
        }
    }
}

extension View {
    func banner(data: BannerType, show: Binding<Bool>, dismissable: Bool = false) -> some View {
        self.modifier(BannerModifier(data: data, show: show, dismissable: dismissable))
    }
}

struct Banner_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            Text("Hello 1")
                .frame(height: 300)
                .background(.brown)
                .banner(data:
                        .warning("Warning"), show: .constant(true))

            Text("Hello 2")
                .banner(data:
                    .error("Error"), show: .constant(true))

            Text("Hello 3")
                .banner(data:
                    .info("Info"), show: .constant(true))
        }
    }
}
