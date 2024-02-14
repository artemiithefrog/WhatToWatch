//
//  URLImage.swift
//  WhatToWatch
//
//  Created by artemiithefrog . on 14.02.2024.
//

import SwiftUI

struct URLImage: View {
    let url: URL
    @State private var image: Image? = nil
    @State private var isLoading = true

    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                image?
                    .resizable()
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
