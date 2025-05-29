// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotesComponents",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NotesComponents",
            targets: ["NotesComponents"]),
    ],
    dependencies: [
        .package(path: "../Modules/NotesTheme")
    ],
    targets: [
        .target(
            name: "NotesComponents",
            dependencies: ["NotesTheme"]),
        .testTarget(
            name: "NotesComponentsTests",
            dependencies: ["NotesComponents"]
        ),
    ]
)
