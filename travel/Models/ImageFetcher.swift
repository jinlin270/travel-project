//
//  ImageFetcher.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//

import SwiftUI

class ImageFetcher: ObservableObject {
    @Published var image: UIImage?
    
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }.resume()
    }
}
