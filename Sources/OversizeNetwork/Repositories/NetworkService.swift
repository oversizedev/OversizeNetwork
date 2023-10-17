//
// Copyright © 2023 Alexander Romanov
// NetworkService.swift, created on 30.06.2023
//
import OpenAPIURLSession
import OversizeModels

public struct NetworkService {
    let client = Client(
        serverURL: try! Servers.server1(),
        transport: URLSessionTransport()
    )

    public init() {}

    public func fetchApps() async -> Result<[Components.Schemas.AppShort], AppError> {
        do {
            let response = try await client.fetchApps(.init())
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
            let response = try await client.fetchInfo(.init())
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
            print(error)
            return .failure(.network(type: .unknown))
        }
    }

    public func fetchAppById(appId: String) async -> Result<Components.Schemas.AppDetail, AppError> {
        do {
            let response = try await client.fetchAppById(.init(path: .init(appId: appId)))
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
            let response = try await client.fetchAds(.init())
            switch response {
            case let .ok(okResponse):
                switch okResponse.body {
                case let .json(ads):
                    return .success(ads)
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
