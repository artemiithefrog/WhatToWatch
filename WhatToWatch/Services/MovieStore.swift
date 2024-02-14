//
//  MovieStore.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 14.02.2024.
//

import Foundation

class MovieStore: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var selectedMovies: [Movie] = []
    
    func fetchMovies() {
        
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzY2ZjZWU2MGVjYmRkOGI1MWY3NjM4YWVjZjJhNDM0OCIsInN1YiI6IjYzODRhMTMwMjI5YWUyMTU3MmE5NGM3MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ozx9VS4Cw1krSYrHD6KESj1ZGi-53a7bavyJNhpPjjM"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/trending/movie/day?language=en-US")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = decodedResponse.results
                    }
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        })
        dataTask.resume()
    }
}
