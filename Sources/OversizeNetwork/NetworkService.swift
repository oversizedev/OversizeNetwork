//
// Copyright © 2023 Alexander Romanov
// File.swift, created on 30.06.2023
//  

import OpenAPIRuntime
import OpenAPIURLSession
import OversizeServices

public actor NetworkService {
    let client: Client
    
    public init() {
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
    }
    
    public func fetchAdsBanners() async -> Result<[Components.Schemas.AdBanner], AppError> {
        do {
            let response = try await client.getBanners(.init())
            switch response {
            case .ok(let okResponse):
                switch okResponse.body {
                case .json(let banners):
                    return .success(banners)
                }
            case .undocumented:
                return .failure(.network(type: .noResponse))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }
}
