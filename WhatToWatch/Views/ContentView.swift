//
//  ContentView.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 20.01.2024.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var movieStore = MovieStore()
    
    var body: some View {
        NavigationView {
            Carousel()
                .navigationTitle("FilmCarousel")
        }
    }
}

#Preview {
    ContentView()
}
