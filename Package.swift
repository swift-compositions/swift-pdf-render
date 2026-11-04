// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-pdf-render",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "PDF Rendering", targets: ["PDF Rendering"]),
        .library(name: "PDF Rendering Test Support", targets: ["PDF Rendering Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-pdf-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-geometry.git", branch: "main", traits: ["Affine"]),
        .package(url: "https://github.com/swift-atoms/swift-direction.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-renderer.git",
            branch: "main",
            traits: ["Document"]
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-copy-on-write.git",
            branch: "main"
        ),
        .package(url: "https://github.com/swift-atoms/swift-ascii.git", branch: "main"),
        .package(
            url: "https://github.com/swift-molecules/swift-layout.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-axis.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-space.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-pair.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ownership.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-byte.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "PDF Rendering",
            dependencies: [
                .product(name: "PDF Standard", package: "swift-pdf-standard"),
                .product(name: "Renderer", package: "swift-renderer"),
                .product(name: "Copy on Write Macro", package: "swift-copy-on-write"),
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "Layout", package: "swift-layout"),
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Pair", package: "swift-pair"),
                .product(name: "Ownership", package: "swift-ownership"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
        .target(
            name: "PDF Rendering Test Support",
            dependencies: [
                .target(name: "PDF Rendering"),
                .product(
                    name: "Space Test Support",
                    package: "swift-space"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "PDF Rendering Tests",
            dependencies: [
                .product(name: "Byte", package: "swift-byte"),
                .target(name: "PDF Rendering"),
                .target(name: "PDF Rendering Test Support"),
            ],
            path: "Tests/PDF Rendering Tests"
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
