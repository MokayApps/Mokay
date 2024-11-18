// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mokay",
    products: [
        .library(
            name: "Mokay",
            targets: ["Mokay"]
		),
    ],
    targets: [
        .target(
            name: "Mokay",
			dependencies: [],
			path: "Mokay/Mokay",
			publicHeadersPath: "Mokay/Mokay"
		),
        .testTarget(
            name: "MokayTests",
            dependencies: ["Mokay"],
			path: "Mokay/MokayTests"
        ),
    ]
)
