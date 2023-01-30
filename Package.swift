// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "nonstrict.eu-website",
    defaultLocalization: "fr_FR",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.9.0"),
        .package(url: "https://github.com/alexito4/ReadingTimePublishPlugin", from: "0.3.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "2.2.4"),
    ],
    targets: [
        .executableTarget(
            name: "NonstrictWebsite",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .product(name: "ReadingTimePublishPlugin", package: "ReadingTimePublishPlugin"),
                .product(name: "Crypto", package: "swift-crypto"),
            ]),
        .testTarget(
            name: "NonstrictWebsiteTests",
            dependencies: ["NonstrictWebsite"]),
    ]
)
