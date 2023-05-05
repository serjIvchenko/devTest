//
//  ImageCacheViewModel.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 03.05.2023.
//

import Foundation
import Combine
import UIKit

extension ImageCacheView {
    
    final class ImageCacheViewModel: ObservableObject {
        
        final class ImageCache {
            static let shared = ImageCache()
            private init() {}
            
            private var cache = NSCache<NSString, UIImage>()
            func imageForKey(_ key: String) -> UIImage? {
                cache.object(forKey: NSString(string: key))
            }
            
            func setImageForKey(_ key: String, image: UIImage) {
                cache.setObject(image, forKey: NSString(string: key))
            }
        }
        
        @Published var image: UIImage?
        
        private let imageCache = ImageCache.shared
        private let urlString: String?
        private let retries: Int
        let errorImage: UIImage?
        
        init(url: String?, errorImage: UIImage?, retries: Int = 1) {
            self.urlString = url//"https://image.tmdb.org/t/p/w500" + (url ?? "")
            self.errorImage = errorImage
            self.retries = retries
            self.load()
        }
        
        private func load() {
            guard !loadImageFromCache() else { return }
            loadImageFromURL()
        }
        
        private func loadImageFromCache() -> Bool {
            guard let urlString = urlString,
                  let cacheImage = imageCache.imageForKey(urlString)
            else { return false }
            image = cacheImage
            return true
        }
        
        private func loadImageFromURL() {
            guard let urlString = urlString, let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTaskPublisher(for: request)
                .tryCatch { error -> URLSession.DataTaskPublisher in
                    guard
                        error.networkUnavailableReason == .constrained,
                        let url = URL(string: urlString) else {
                        throw error
                    }
                    return URLSession.shared.dataTaskPublisher(for: url)
                }
                .tryMap {
                    guard let response = $0.response as? HTTPURLResponse,
                          response.statusCode == 200,
                          let image = UIImage(data: $0.data)
                    else {
                        throw Error.invalidResponse
                    }
                    self.imageCache.setImageForKey(urlString, image: image)
                    return image
                }
                .retry(retries)
                .replaceError(with: errorImage)
                .receive(on: DispatchQueue.main)
                .assign(to: &$image)
        }
    }
}
