//
// Copyright © 2023 Alexander Romanov
// NetworkService.swift, created on 30.06.2023
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import OversizeModels

public struct NetworkService: Sendable {
    private let client: any APIProtocol

    init(underlyingClient: any APIProtocol) { client = underlyingClient }

    public init() {
        self.init(
            underlyingClient: Client(
                serverURL: try! Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        )
    }

    public func fetchApps() async -> Result<[Components.Schemas.App], AppError> {
        do {
            let response = try await client.getApps()
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(apps):
                    return .success(apps)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchInfo() async -> Result<Components.Schemas.Info, AppError> {
        do {
            let response = try await client.fetchInfo(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(info):
                    return .success(info)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchApp(appId: String) async -> Result<Components.Schemas.App, AppError> {
        do {
            let response = try await client.getApp(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(info):
                    return .success(info)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAds(appId: String) async -> Result<[Components.Schemas.Ad], AppError> {
        do {
            let response = try await client.getAppAds(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(ads):
                    return .success(ads)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAd(appId: String) async -> Result<Components.Schemas.Ad, AppError> {
        do {
            let response = try await client.getAppAd(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(ads):
                    return .success(ads)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchSpecialOffers() async -> Result<[Components.Schemas.SaleOffer], AppError> {
        do {
            let response = try await client.getSaleOffers()
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(offers):
                    return .success(offers)
                }
            case .undocumented, .badRequest:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAppStoreProductIds(appId: String) async -> Result<[String], AppError> {
        do {
            let response = try await client.GetAppStoreProductIds(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(productIds):
                    return .success(productIds)
                }
            default:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAppStoreProducts(appId: String) async -> Result<Components.Schemas.AppStoreProducts, AppError> {
        do {
            let response = try await client.GetAppStoreProducts(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(productIds):
                    return .success(productIds)
                }
            default:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchPremiumFeatures(appId: String) async -> Result<[Components.Schemas.Feature], AppError> {
        do {
            let response = try await client.getAppFeatures(.init(path: .init(id: appId), query: .init(context: .paywall)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(productIds):
                    return .success(productIds)
                }
            default:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }
}
