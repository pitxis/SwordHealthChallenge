//
//  DogsWithSwordsApp.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 27/06/2023.
//

import SwiftUI

@main
struct DogsWithSwordsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(contentViewModel: ContentViewModel(networkMonitor: DIContainer.networkMonitor),
                        coordinator: CoordinatorObject(networkMonitor: DIContainer.networkMonitor))
        }
    }
}
