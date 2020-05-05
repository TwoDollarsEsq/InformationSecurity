// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "RSA",
    products: [
        .library(
            name: "RSA",
            targets: ["RSA"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/attaswift/BigInt",
            .upToNextMajor(from: "5.1.0")),
    ],
    targets: [
        .target(
            name: "RSA",
            dependencies: ["BigInt"]),
        .testTarget(
            name: "RSATests",
            dependencies: ["RSA"]),
    ]
)
