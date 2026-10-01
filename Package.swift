// swift-tools-version: 6.4

import PackageDescription

extension String {
    static let pdfRendering: Self = "PDF Rendering"
    var tests: Self { self + " Tests" }
}

extension Target.Dependency {
    static var pdfRendering: Self { .target(name: .pdfRendering) }
}

extension Target.Dependency {
    static var pdfStandard: Self {
        .product(name: "PDF Standard", package: "swift-pdf-standard")
    }
    static var renderingPrimitives: Self {
        .product(name: "Renderer", package: "swift-renderer")
    }
    static var copyOnWrite: Self {
        .product(name: "Copy on Write Macro", package: "swift-copy-on-write")
    }
    static var ascii: Self {
        .product(name: "ASCII", package: "swift-ascii")
    }
    static var layoutPrimitives: Self {
        .product(name: "Layout", package: "swift-layout")
    }
    static var propertyPrimitives: Self {
        .product(name: "Property", package: "swift-property")
    }
    static var pairPrimitives: Self {
        .product(name: "Pair", package: "swift-pair")
    }
    static var ownershipMutablePrimitives: Self {
        .product(name: "Ownership", package: "swift-ownership")
    }
    static var bytePrimitives: Self {
        .product(name: "Byte", package: "swift-byte")
    }
}

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
        .library(name: .pdfRendering, targets: [.pdfRendering]),
        .library(name: "PDF Rendering Test Support", targets: ["PDF Rendering Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-standards/swift-pdf-standard.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-geometry.git", branch: "main", traits: ["Affine"]),
        .package(url: "https://github.com/swift-atoms/swift-direction.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-renderer.git",
            branch: "main", traits: ["Document"]),
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
            url: "https://github.com/swift-atoms/swift-spatial.git",
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
            name: .pdfRendering,
            dependencies: [
                .pdfStandard,
                .renderingPrimitives,
                .copyOnWrite,
                .ascii,
                .layoutPrimitives,
                .product(name: "Axis", package: "swift-axis"),
                .product(name: "Direction", package: "swift-direction"),
                .propertyPrimitives,
                .pairPrimitives,
                .ownershipMutablePrimitives,
                .bytePrimitives,
            ]
        ),
        .target(
            name: "PDF Rendering Test Support",
            dependencies: [
                .pdfRendering,
                .product(
                    name: "Space Test Support",
                    package: "swift-spatial"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: .pdfRendering.tests,
            dependencies: [
                .pdfRendering,
                "PDF Rendering Test Support",
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
