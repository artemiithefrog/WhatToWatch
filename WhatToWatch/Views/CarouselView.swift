//
//  CarouselView.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 14.02.2024.
//

import SwiftUI

struct CarouselView: View {
    
    @StateObject var movieStore = MovieStore()
    @State private var currentIndex: Int = 0
    @State private var showSelectedMovies = false
    @State private var movies: [Movie] = []
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<movieStore.selectedMovies.count, id: \.self) { index in
                        URLImage(url: movieStore.selectedMovies[index].posterURL)
                            .frame(width: 310, height: 175)
                            .cornerRadius(15)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 500,
                                    y: 0)
                    }
                }
                if movieStore.selectedMovies.isEmpty {
                    Text("Select Movies")
                } else {
                    Text("Selected movie: \(movieStore.selectedMovies[currentIndex].title)")
                        .padding(.top, 20)
                        .bold()
                        .font(.system(size: 20))
                }
                
                Button("Select Movies") {
                    showSelectedMovies = true
                }
                .bold()
                
                Button("Spin") {
                    movies = movieStore.selectedMovies
                    spinColors()
                }
                .bold()
            }
            .sheet(isPresented: $showSelectedMovies) {
                Movies()
                    .environmentObject(movieStore)
            }
            .navigationTitle("FilmCarousel")
        }
    }

    func spinColors() {
        let spinCount = Int.random(in: 25...50)
        var currentCount = 0
        let addedFilms = spinCount / movieStore.selectedMovies.count
        
        for _ in 0...addedFilms {
            movieStore.selectedMovies += movies
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            withAnimation {
                currentIndex = (currentIndex + 1) % movieStore.selectedMovies.count
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
    CarouselView()
}
