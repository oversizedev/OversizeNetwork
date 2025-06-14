//
// Copyright © 2023 Alexander Romanov
// ServiceRegistering.swift, created on 30.06.2023
//

import FactoryKit
import Foundation

public extension Container {
    var networkService: Factory<NetworkService> {
        self { NetworkService() }
    }
}
