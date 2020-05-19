// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "DSA",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "DSA",
            targets: ["DSA"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/attaswift/BigInt",
            .upToNextMajor(from: "5.1.0")),
    ],
    targets: [
        .target(
            name: "DSA",
            dependencies: ["BigInt"]),
        .testTarget(
            name: "DSATests",
            dependencies: ["DSA"]),
    ]
)
