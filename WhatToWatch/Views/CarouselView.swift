//
//  CarouselView.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 14.02.2024.
//

import SwiftUI

struct CarouselView: View {
    
    @EnvironmentObject var movieStore: MovieStore
    @State private var currentIndex: Int = 0
    @State private var showSelectedMovies = false
    @State private var movies: [Movie] = []
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<movieStore.selectedMovies.count, id: \.self) { index in
                        URLImage(url: movieStore.selectedMovies[index].posterURL)
                            .frame(width: 175, height: 310)
                            .cornerRadius(15)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * 500,
                                    y: 0)
                            .onChange(of: currentIndex) {
                                print(index)
                            }
                    }
                }
                
                
                if movieStore.selectedMovies.isEmpty {
                } else {
                    Button("Spin") {
                        movies = movieStore.selectedMovies
                        spinColors()
                    }
                    .bold()
                    .tint(.white)
                    .padding(.top, 25)
                }
                
                Button("Select Movies") {
                    showSelectedMovies = true
                }
                .bold()
                .tint(.white)
            }
            .sheet(isPresented: $showSelectedMovies) {
                Movies()
                    .environmentObject(movieStore)
            }
            .navigationTitle("FilmCarousel")
        }
    }
    
    func spinColors() {
        let spinCount = Int.random(in: 75...125)
        var currentCount = 0
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            
            currentCount += 1
            
            if currentIndex >= movieStore.selectedMovies.count - 1 {
                currentIndex = 0
            } else {
                withAnimation {
                    currentIndex += 1
                }
            }
            
            withAnimation {
                movieStore.selectedMovies.append(movieStore.selectedMovies.first!)
                movieStore.selectedMovies.remove(at: 0)
            }
            
            
            if currentCount == spinCount {
                timer.invalidate()
                currentCount = 0
            }
        }
    }
}

#Preview {
    CarouselView()
}
