//
//  MockNetworkMonitor.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 03/07/2023.
//

import Foundation
import Combine
@testable import DogsWithSwords

class MockNetworkMonitor: NetworkMonitorProtocol {
    var status: NetworkStatus = .online
    func isOffline() -> AnyPublisher<DogsWithSwords.NetworkStatus, Never> {
        Just(status).eraseToAnyPublisher()
    }
}
