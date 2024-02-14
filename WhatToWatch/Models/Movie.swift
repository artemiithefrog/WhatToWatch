//
//  Movie.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 14.02.2024.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")!
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview, posterPath = "poster_path"
    }
}
