// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TPCore",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "TPCore", targets: ["TPCore"])
    ],
    dependencies: [],
    targets: [
        .target(name: "TPCore", dependencies: [])
    ]
)
