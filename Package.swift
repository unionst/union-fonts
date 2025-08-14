// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "union-fonts",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "UnionFonts",
            targets: ["UnionFonts"]
        ),
    ],
    targets: [
        .target(
            name: "UnionFonts",
            path: "Sources/union-fonts"
        ),
        .testTarget(
            name: "UnionFontsTests",
            dependencies: ["UnionFonts"],
            path: "Tests/UnionFontsTests"
        )
    ]
)
