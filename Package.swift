// swift-tools-version:5.0

/**
 *  Warhol
 *  Copyright (c) César Vargas Casaseca 2020
 *  Licensed under the MIT license (see LICENSE file)
 */

import PackageDescription

let package = Package(
    name: "Wyler",
    platforms: [
      .iOS(.v11)],
    products: [
        .library(
            name: "Wyler",
            targets: ["Wyler"]
        )
    ],
    targets: [
        .target(name: "Wyler",
                path: "Wyler/Wyler")
    ]
)
