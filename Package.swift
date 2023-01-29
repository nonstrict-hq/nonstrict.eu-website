// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "nonstrict.eu-website",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.9.0")
    ],
    targets: [
        .executableTarget(
            name: "NonstrictWebsite",
            dependencies: [.product(name: "Publish", package: "publish")]),
        .testTarget(
            name: "NonstrictWebsiteTests",
            dependencies: ["NonstrictWebsite"]),
    ]
)
