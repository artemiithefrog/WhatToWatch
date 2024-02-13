//
//  ContentView.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 20.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State var colors: [Color] = [.red, .orange, .yellow, .green, .blue]
    
    var body: some View {
        NavigationStack {
            Carousel()
                .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
