//
// Copyright © 2023 Alexander Romanov
// APIServer.swift
//

import Foundation

public enum APIServer: String, CaseIterable, Identifiable, Sendable {
    case production
    case test

    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .production: "Production"
        case .test: "Test"
        }
    }

    public var url: URL {
        switch self {
        case .production: try! Servers.Server1.url()
        case .test: try! Servers.Server2.url()
        }
    }

    static let userDefaultsKey = "OversizeNetwork.apiServer"

    public static var stored: APIServer {
        guard let raw = UserDefaults.standard.string(forKey: userDefaultsKey),
              let server = APIServer(rawValue: raw) else { return .production }
        return server
    }

    public func store() {
        UserDefaults.standard.set(rawValue, forKey: APIServer.userDefaultsKey)
    }
}
