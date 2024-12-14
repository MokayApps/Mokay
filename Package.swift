// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Mokay",
	platforms: [
		.iOS(.v17),
		.macOS(.v14)
	],
    products: [
        .library(
            name: "Mokay",
            targets: [
				"MokayDB",
				"MokayDI",
				"MokayNW"
			]
		),
    ],
	dependencies: [],
    targets: [
        .target(
            name: "MokayDB",
			dependencies: [],
			path: "Mokay/Mokay/Database",
			publicHeadersPath: "Mokay/Mokay"
		),
		.target(
            name: "MokayDI",
			dependencies: [],
			path: "Mokay/Mokay/DI",
			publicHeadersPath: "Mokay/Mokay"
		),
		.target(
			name: "MokayNW",
			dependencies: [],
			path: "Mokay/Mokay/HTTPClient",
			publicHeadersPath: "Mokay/Mokay"
		),
		.target(
			name: "MokayUI",
			dependencies: [],
			path: "Mokay/Mokay/DesignKit",
			publicHeadersPath: "Mokay/Mokay"
		),
        .testTarget(
            name: "MokayTests",
            dependencies: [
				"MokayDB",
				"MokayDI",
				"MokayNW",
				"MokayUI"
			],
			path: "Mokay/MokayTests"
        ),
    ]
)
