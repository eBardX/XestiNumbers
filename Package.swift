// swift-tools-version: 6.2

// © 2025–2026 John Gary Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.defaultIsolation(nil),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ImmutableWeakCaptures"),
                                     .enableUpcomingFeature("InferIsolatedConformances"),
                                     .enableUpcomingFeature("InternalImportsByDefault"),
                                     .enableUpcomingFeature("MemberImportVisibility"),
                                     .enableUpcomingFeature("NonisolatedNonsendingByDefault")]

let package = Package(name: "XestiNumbers",
                      platforms: [.iOS(.v16),
                                  .macOS(.v14)],
                      products: [.library(name: "XestiNumbers",
                                          targets: ["XestiNumbers"])],
                      dependencies: [.package(url: "https://github.com/attaswift/BigInt.git",
                                              .upToNextMajor(from: "5.7.0")),
                                     .package(url: "https://github.com/apple/swift-numerics",
                                              .upToNextMajor(from: "1.1.0")),
                                     .package(url: "https://github.com/eBardX/XestiTools.git",
                                              .upToNextMajor(from: "7.2.0"))],
                      targets: [.target(name: "XestiNumbers",
                                        dependencies: [.product(name: "BigInt",
                                                                package: "BigInt"),
                                                       .product(name: "Numerics",
                                                                package: "swift-numerics"),
                                                       .product(name: "XestiTools",
                                                                package: "XestiTools")],
                                        swiftSettings: swiftSettings),
                                .testTarget(name: "XestiNumbersTests",
                                            dependencies: [.target(name: "XestiNumbers")],
                                            swiftSettings: swiftSettings)],
                      swiftLanguageModes: [.v6])
