//
// Copyright © 2023 Alexander Romanov
// NetworkService.swift, created on 30.06.2023
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import OversizeModels

public struct NetworkService {
    private let underlyingClient: any APIProtocol

    init(underlyingClient: any APIProtocol) { self.underlyingClient = underlyingClient }

    public init() {
        self.init(
            underlyingClient: Client(
                serverURL: try! Servers.server1(),
                transport: URLSessionTransport()
            )
        )
    }

    public func fetchApps() async -> Result<[Components.Schemas.AppShort], AppError> {
        do {
            let response = try await underlyingClient.fetchApps(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(apps):
                    return .success(apps)
                }
            case .undocumented:
                return .failure(.network(type: .unexpectedStatusCode))
            case .notFound:
                return .failure(.network(type: .invalidURL))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchInfo() async -> Result<Components.Schemas.Info, AppError> {
        do {
            let response = try await underlyingClient.fetchInfo(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(info):
                    return .success(info)
                }
            case .undocumented:
                return .failure(.network(type: .unexpectedStatusCode))
            case .notFound:
                return .failure(.network(type: .invalidURL))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAppById(appId: String) async -> Result<Components.Schemas.AppDetail, AppError> {
        do {
            let response = try await underlyingClient.fetchAppById(.init(path: .init(appId: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(info):
                    return .success(info)
                }
            case .undocumented:
                return .failure(.network(type: .unexpectedStatusCode))
            case .notFound:
                return .failure(.network(type: .invalidURL))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAds() async -> Result<[Components.Schemas.Ad], AppError> {
        do {
            let response = try await underlyingClient.fetchAds(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(ads):
                    return .success(ads.ads)
                }
            case .undocumented:
                return .failure(.network(type: .unexpectedStatusCode))
            case .notFound:
                return .failure(.network(type: .invalidURL))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchSpecialOffers() async -> Result<[Components.Schemas.SpecialOffer], AppError> {
        do {
            let response = try await underlyingClient.fetchSpecialOffers(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(ads):
                    return .success(ads.offers)
                }
            case .undocumented:
                return .failure(.network(type: .unexpectedStatusCode))
            case .notFound:
                return .failure(.network(type: .invalidURL))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }
}
