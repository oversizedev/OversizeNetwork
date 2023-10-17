// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

private extension PackageDescription.Target.Dependency {
    static let openAPIRuntime: Self = .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime")
    static let openAPIURLSession: Self = .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession")
    static let factory: Self = .product(name: "Factory", package: "Factory")
    static let oversizeModels: Self = .product(name: "OversizeModels", package: "OversizeModels")
}

private extension PackageDescription.Target.PluginUsage {
    static let openAPIGenerator: Self = .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
}

import PackageDescription

let package = Package(
    name: "OversizeNetwork",
    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8),
    ],
    products: [
        .library(
            name: "OversizeNetwork",
            targets: ["OversizeNetwork"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/apple/swift-openapi-runtime", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", .upToNextMinor(from: "0.3.0")),
        .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
        .package(url: "https://github.com/oversizedev/OversizeModels.git", .upToNextMajor(from: "0.1.0")),
        //.package(name: "OversizeModels", path: "../OversizeModels"),
    ],
    targets: [
        .target(
            name: "OversizeNetwork",
            dependencies: [
                .openAPIRuntime,
                .openAPIURLSession,
                .factory,
                .oversizeModels,
            ],
            path: "./Sources/OversizeNetwork/Repositories",
            plugins: [
                .openAPIGenerator,
            ]
        ),
    ]
)
