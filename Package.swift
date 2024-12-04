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
	dependencies: [
		.package(url: "https://github.com/apple/swift-syntax", from: "509.0.0")
	],
    targets: [
        .target(
            name: "MokayDB",
			dependencies: [],
			path: "Mokay/Mokay/Database",
			publicHeadersPath: "Mokay/Mokay"
		),
		.target(
            name: "MokayDI",
			dependencies: [
				"MokayMacros"
			],
			path: "Mokay/Mokay/DI",
			publicHeadersPath: "Mokay/Mokay"
		),
		.target(
			name: "MokayNW",
			dependencies: [],
			path: "Mokay/Mokay/HTTPClient",
			publicHeadersPath: "Mokay/Mokay"
		),
		.macro(
			name: "MokayMacros",
			dependencies: [
				.product(name: "SwiftSyntax", package: "swift-syntax"),
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
				.product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
			],
			path: "Mokay/Mokay/Macros"
		),
        .testTarget(
            name: "MokayTests",
            dependencies: [
				"MokayDB",
				"MokayDI",
				"MokayNW"
			],
			path: "Mokay/MokayTests"
        ),
    ]
)
