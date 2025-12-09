// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "day08",
    platforms: [
        .macOS(.v13)
    ],
    targets: [
        .executableTarget(
            name: "day08",
            path: "Sources"
        ),
        .testTarget(
            name: "Day08Tests",
            dependencies: ["day08"],
            path: "Tests"
        ),
    ]
)
