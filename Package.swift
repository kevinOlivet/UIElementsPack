// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIElementsPack",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "UIElementsPack",
            targets: ["UIElementsPack"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kevinOlivet/CommonsPack.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "UIElementsPack",
            dependencies: [],
            resources: [
                .copy("Resources")
            ]
        ),
        .testTarget(
            name: "UIElementsPackTests",
            dependencies: ["UIElementsPack"]),
    ]
)
