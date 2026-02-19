import Foundation
import HTTPTypes
import OpenAPIRuntime

public struct RequestHeaders: Sendable {
    public var appBundleId: String?
    public var acceptLanguage: String?
    public var appStoreId: String?

    public init(
        appBundleId: String? = nil,
        acceptLanguage: String? = nil,
        appStoreId: String? = nil,
    ) {
        self.appBundleId = appBundleId
        self.acceptLanguage = acceptLanguage
        self.appStoreId = appStoreId
    }
}

public actor RequestHeadersStore: Sendable {
    private var headers: RequestHeaders

    public init(headers: RequestHeaders) {
        self.headers = headers
    }

    public func update(_ headers: RequestHeaders) {
        self.headers = headers
    }

    public func current() -> RequestHeaders {
        headers
    }
}

public struct RequestHeadersMiddleware: ClientMiddleware {
    private let store: RequestHeadersStore

    public init(store: RequestHeadersStore) {
        self.store = store
    }

    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID _: String,
        next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?),
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        let headers = await store.current()
        applyHeaderIfMissing("App-Bundle-ID", value: headers.appBundleId, to: &request)
        applyHeaderIfMissing("Accept-Language", value: headers.acceptLanguage, to: &request)
        applyHeaderIfMissing("App-Store-ID", value: headers.appStoreId, to: &request)
        return try await next(request, body, baseURL)
    }

    private func applyHeaderIfMissing(_ name: String, value: String?, to request: inout HTTPRequest) {
        guard let value, let fieldName = HTTPField.Name(name) else {
            return
        }
        if request.headerFields[fieldName] == nil {
            request.headerFields[fieldName] = value
        }
    }
}
