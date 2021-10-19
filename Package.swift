// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIElementsPack",
    defaultLocalization: "en",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "UIElementsPack",
            targets: ["UIElementsPack"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kevinOlivet/CommonsPack.git", .upToNextMajor(from: "1.0.0"))
//        .package(name: "CommonsPack", path: "../CommonsPack")
    ],
    targets: [
        .target(
            name: "UIElementsPack",
            dependencies: ["CommonsPack"],
            resources: [
//                .copy("Resources")
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "UIElementsPackTests",
            dependencies: [
                "UIElementsPack",
                "CommonsPack"
            ]
        ),
    ]
)
