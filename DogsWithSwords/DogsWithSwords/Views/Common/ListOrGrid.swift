//
//  ListOrGrid.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//

import SwiftUI

struct ListOrGrid<Content: View>: View {
    @ObservedObject var typeObserver: ListTypeObserver

    let columns = [
        GridItem(.adaptive(minimum: 120), spacing: 0)
    ]

    let content: Content

    init(type: ListTypeObserver, @ViewBuilder _ content: () -> Content) {
        self.content = content()
        self.typeObserver = type
    }

    var body: some View {
        ScrollViewReader { scroller in
            if typeObserver.type == .list {
                List {
                    content
                }
                .onAppear {
                    scroller.scrollTo(typeObserver.scrollTargetId, anchor: .top)
                }
            } else {
                HStack {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 0) {
                            content.padding([.leading, .trailing], 4)
                        }
                    }
                    .onAppear {
                        scroller.scrollTo(typeObserver.scrollTargetId, anchor: .top)
                    }
                }
            }
        }
        .background(Color.background)
    }
}
