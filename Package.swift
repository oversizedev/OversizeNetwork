// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let commonDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-openapi-generator", .upToNextMinor(from: "1.9.0")),
    .package(url: "https://github.com/apple/swift-openapi-runtime", .upToNextMinor(from: "1.8.2")),
    .package(url: "https://github.com/apple/swift-openapi-urlsession", .upToNextMinor(from: "1.1.0")),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "2.1.3")),
]

let remoteDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(url: "https://github.com/oversizedev/OversizeModels.git", .upToNextMajor(from: "0.1.0")),
]

let localDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(name: "OversizeModels", path: "../OversizeModels"),
]

let dependencies: [PackageDescription.Package.Dependency] = remoteDependencies

let package = Package(
    name: "OversizeNetwork",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "OversizeNetwork",
            targets: ["OversizeNetwork"],
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: "OversizeNetwork",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                .product(name: "FactoryKit", package: "Factory"),
                .product(name: "OversizeModels", package: "OversizeModels"),
            ],
            plugins: [
                // .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
            ],

        ),
    ],
)
