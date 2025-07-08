//
//  ConnectivityMonitor.swift
//  Pokemon
//
//  Created by Steven Lie on 08/07/25.
//

import Network

final class ConnectivityMonitor {
    static let shared = ConnectivityMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = true
    
    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
