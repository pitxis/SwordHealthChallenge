//
//  NetworkMonitoring.swift
//  DogsWithSwords
//
//  Created by Manuel Peixoto on 01/07/2023.
//


import Combine
import Network

enum NetworkStatus {
    case online
    case offline
    case undifined
}

protocol NetworkMonitorProtocol: ObservableObject {
    func isOffline() -> AnyPublisher<NetworkStatus, Never>
}

class NetworkMonitor: NetworkMonitorProtocol {
    @Published var status: NetworkStatus = .undifined
    private var monitor: NWPathMonitor

    let queue = DispatchQueue.global(qos: .background)

    init() {
        self.monitor = NWPathMonitor()
        self.startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.status = .online
                } else {
                    self?.status = .offline
                }
            }
        }

        monitor.start(queue: queue)
    }

    func isOffline() -> AnyPublisher<NetworkStatus, Never> {
        self.$status.eraseToAnyPublisher()
    }
}
