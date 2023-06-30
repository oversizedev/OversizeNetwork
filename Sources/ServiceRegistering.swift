//
// Copyright © 2023 Alexander Romanov
// ServiceRegistering.swift, created on 30.06.2023
//

import Factory
import Foundation
import OversizeServices

public extension Container {
    var networkService: Factory<NetworkService> {
        self { NetworkService() }
    }
}

