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
            VStack {
                ZStack {
                    ForEach(0..<colors.count, id: \.self) { index in
                        Color(colors[index])
                            .frame(width: 300, height: 500)
                            .cornerRadius(25)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset,
                                    y: 0)
                        
                    }
                }
                .gesture (
                    DragGesture()
                        .onEnded { value in
                            let threshold: CGFloat = 50
                            if value.translation.width > threshold {
                                withAnimation {
                                    currentIndex = max(0, currentIndex - 1)
                                    print(currentIndex)
                                }
                            } else if value.translation.width < threshold {
                                withAnimation {
                                    currentIndex = min(colors.count - 1, currentIndex + 1)
                                    print(currentIndex)
                                }
                            }
                        }
                )
            }
            .navigationTitle("ImageCarousel")
        }
    }
}

#Preview {
    ContentView()
}
