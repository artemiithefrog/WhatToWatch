//
//  Films.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 14.02.2024.
//

import SwiftUI

struct Movies: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var movieStore = MovieStore()
    
    private var data = Array(1...20)
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                    ForEach(movieStore.movies) { movie in
                        URLImage(url: movie.posterURL)
                            .frame(width: 150, height: 225, alignment: .center)
                            .cornerRadius(10)
                    }
                }
            }
            .onAppear {
                movieStore.fetchMovies()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                    }
                    .tint(.black)
                }
            }
        }
    }
}

#Preview {
    Movies()
}
