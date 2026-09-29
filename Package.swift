// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-xml",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "XML", targets: ["XML"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-array.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-linear.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership-shared.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-w3c/swift-w3c-xml.git", branch: "main"),
        .package(url: "https://github.com/swift-molecules/swift-async-stream.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "XML",
            dependencies: [
                .product(name: "Array", package: "swift-array"),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear"
                ),
                .product(
                    name: "Buffer Linear",
                    package: "swift-buffer-linear"
                ),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(name: "W3C XML", package: "swift-w3c-xml"),
                .product(name: "Async Stream", package: "swift-async-stream"),
            ]
        ),
        .testTarget(
            name: "XML Tests",
            dependencies: [
                "XML"
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
