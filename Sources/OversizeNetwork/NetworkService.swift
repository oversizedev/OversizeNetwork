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
            ))
    }

    public func fetchApps() async -> Result<[Components.Schemas.App], AppError> {
        do {
            let response = try await client.getApps()
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(apps):
                    return .success(apps.apps)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchCompany() async -> Result<Components.Schemas.Company, AppError> {
        do {
            let response = try await client.getInfo(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(info):
                    return .success(info.company)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchDeveloper() async -> Result<Components.Schemas.Developer, AppError> {
        do {
            let response = try await client.getInfo(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(info):
                    return .success(info.developer)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchInfo() async -> Result<InfoResponse, AppError> {
        do {
            let response = try await client.getInfo(.init())
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
                case let .json(app):
                    return .success(app.app)
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
                    return .success(ads.ads)
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
                    return .success(ads.ad)
                }
            default:
                return .failure(.network(type: .unknown))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchSpecialOffers() async -> Result<[Components.Schemas.InAppPurchaseOffer], AppError> {
        do {
            let response = try await client.getInAppPurchaseOffers()
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(offers):
                    return .success(offers.offers)
                }
            case .undocumented, .badRequest, .internalServerError, .notFound:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAppStoreProductIds(appId: String) async -> Result<[String], AppError> {
        do {
            let response = try await client.getInAppPurchases(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(productIds):
                    return .success(productIds.productIds)
                }
            default:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAppStoreBanner(appId: String) async -> Result<Components.Schemas.InAppPurchaseBanner, AppError> {
        do {
            let response = try await client.getInAppPurchases(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(productIds):
                    return .success(productIds.banner)
                }
            default:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchInAppPurchases(appId: String) async -> Result<InAppPurchaseResponse, AppError> {
        do {
            let response = try await client.getInAppPurchases(.init(path: .init(id: appId)))
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(body):
                    return .success(body)
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
                    return .success(productIds.features)
                }
            default:
                return .failure(.network(type: .unexpectedStatusCode))
            }
        } catch {
            return .failure(.network(type: .unknown))
        }
    }
}
