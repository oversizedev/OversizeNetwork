// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let commonDependencies: [PackageDescription.Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-openapi-generator", .upToNextMajor(from: "1.10.2")),
    .package(url: "https://github.com/apple/swift-openapi-runtime", .upToNextMajor(from: "1.8.2")),
    .package(url: "https://github.com/apple/swift-openapi-urlsession", .upToNextMajor(from: "1.1.0")),
    .package(url: "https://github.com/hmlongco/Factory.git", .upToNextMajor(from: "3.0.2")),
]

let remoteDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(url: "https://github.com/oversizedev/OversizeCore.git", .upToNextMajor(from: "1.3.0")),
]

let localDependencies: [PackageDescription.Package.Dependency] = commonDependencies + [
    .package(name: "OversizeCore", path: "../OversizeCore"),
]

let isLocalDev = FileManager.default.fileExists(atPath: "\(NSHomeDirectory())/Developer/Packages/OversizeCore")
let dependencies: [PackageDescription.Package.Dependency] = isLocalDev ? localDependencies : remoteDependencies

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
                .product(name: "OversizeCore", package: "OversizeCore"),
            ],
            plugins: [
                // .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
            ],

        ),
    ],
)
