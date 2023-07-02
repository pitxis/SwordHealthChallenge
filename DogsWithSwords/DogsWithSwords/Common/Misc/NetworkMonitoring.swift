//
//  NetworkMonitoring.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//

import SwiftUI
import Combine
import Network

class NetworkMonitor: ObservableObject {
    @Published var isOffline: Bool = false
    private var monitor: NWPathMonitor

    let queue = DispatchQueue.global(qos: .background)

    init() {
        self.monitor = NWPathMonitor()
        self.startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                    self?.isOffline = false
                } else {
                    self?.isOffline = true
                }
        }

        monitor.start(queue: queue)
    }
}
