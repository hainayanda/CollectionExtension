// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CollectionExtension",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "CollectionExtension",
            targets: ["CollectionExtension"]
        )
    ],
    dependencies: [
        // uncomment code below to test
//        .package(url: "https://github.com/Quick/Quick.git", from: "7.0.0"),
//        .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0")
    ],
    targets: [
        .target(
            name: "CollectionExtension",
            dependencies: [],
            path: "CollectionExtension/Classes"
        ),
        // uncomment code below to test
//        .testTarget(
//            name: "CollectionExtensionTests",
//            dependencies: [
//                "CollectionExtension", "Quick", "Nimble"
//            ],
//            path: "Example/Tests",
//            exclude: ["Info.plist"]
//        )
    ]
)