// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "GenericCells",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "GenericCells",
            targets: ["GenericCells"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GenericCells",
            dependencies: [])
    ]
)
