//
//  WhatToWatchApp.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 20.01.2024.
//

import SwiftUI

@main
struct WhatToWatchApp: App {
    
    var body: some Scene {
        WindowGroup {
            CarouselView()
                .preferredColorScheme(.dark)
        }
    }
}
