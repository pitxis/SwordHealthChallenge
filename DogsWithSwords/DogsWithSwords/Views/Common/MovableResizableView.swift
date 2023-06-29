//
//  MovableResizableView.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 29/06/2023.
//

import SwiftUI

struct MovableResizableView<Content>: View where Content: View {
    @State private var finalScale: CGFloat = 1
    @State private var newPosition: CGSize = .zero
    @State private var isDragging = false
    @Binding var isPresented: Bool

    var content: () -> Content

    var body: some View {
        GeometryReader { proxy in
            content()
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
                .scaleEffect(finalScale)
                .offset(x: newPosition.width, y: newPosition.height)
                .animation(Animation.easeOut(duration: 0.24), value: 0)
                .gesture(DragGesture()
                    .onChanged({ value in
                        if value.translation.height > 0 {
                            self.finalScale = finalScale + value.translation.height / (proxy.size.height * 100)
                            self.newPosition.height = newPosition.height + value.translation.height / 50
                        }
                    })

                        .onEnded({ value in

                            withAnimation(.interpolatingSpring(stiffness: 300, damping: 20)) {
                                if value.translation.height > 100 {
                                    self.isPresented = false
                                }
                                finalScale = 1
                                self.newPosition.height = 0
                            }
                        })
                )
        }
    }
}
