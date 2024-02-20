//
//  Carousel.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 31.01.2024.
//

import SwiftUI

struct Carousel: View {
    @State private var currentIndex: Int = 0
//    @GestureState private var dragOffset: CGFloat = 0
    
    @State private var films = ["darkKnight", "ESB", "Godfather", "Jaws", "PulpFiction", "Shawshank"]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<films.count, id: \.self) { index in
                        Image(films[index])
                            .resizable()
                            .frame(width: 310, height: 175)
                            .cornerRadius(15)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 500,
                                    y: 0)
                    }
                }
                Text("Selected film: \(films[currentIndex].description)")
                    .padding(.top, 20)
                    .bold()
                    .font(.system(size: 20))
                
                Button("Spin") {
                    spinColors()
                }
                .bold()
            }
            .navigationTitle("FilmCarousel")
        }
    }
    
    func spinColors() {
        let spinCount = Int.random(in: 25...50)
        var currentCount = 0
        let film = ["darkKnight", "ESB", "Godfather", "Jaws", "PulpFiction", "Shawshank"]
        let addedFilms = spinCount / films.count
        
        for _ in 0...addedFilms {
            films += film
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            withAnimation {
                currentIndex = (currentIndex + 1) % films.count
                currentCount += 1
                
                if currentCount == spinCount {
                    timer.invalidate()
                    currentCount = 0
                }
            }
        }
    }
}

#Preview {
    Carousel()
}
