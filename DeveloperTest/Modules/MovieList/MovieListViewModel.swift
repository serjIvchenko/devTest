//
//  MovieListViewModel.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 01.05.2023.
//

import Foundation
import Combine
import SwiftUI

extension MovieListView {
    
    enum State: Equatable {
        case loading
        case loaded
    }
    
    final class MovieListViewModel: ObservableObject {
        
        @Published var state: State = .loading
        @Published var movies: [Movie] = [] {
            willSet {
                for item in newValue {
                    countCharacters(in: item.title)
                }
            }
        }
        
        let navigationTransition = AnyTransition.opacity.animation(.easeOut(duration: 2))
        let api: API
        var router: Router
        var subscriptions: [AnyCancellable]
        
        init(router: Router) {
            self.api = API()
            self.router = router
            self.subscriptions = [AnyCancellable]()
            self.loadMovie()
        }
        
        func loadMovie() {
            if state == .loaded {
                state = .loading
            }
            api.topRatedMovie()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { print($0) }, receiveValue: { value in
                    DispatchQueue.main.async { [weak self] in
                        print(value)
                        self?.movies = Array(value.items.prefix(10))
                        if !value.items.isEmpty {
                            self?.state = .loaded
                        }
                    }
                })
                .store(in: &subscriptions)
        }
        
        func setPathToMovieDetails(movie: Movie) {
            router.push(to: .movieDetails(movie: movie))
        }
        
        func goToMovieDetails(movie: Movie) -> MovieDetailsView {
            return router.goToMovieDetails(movie: movie)
        }
        
        private func countCharacters(in title: String) {
            var charCount = [Character: Int]()
            
            for char in title {
                if let count = charCount[char] {
                    charCount[char] = count + 1
                } else {
                    charCount[char] = 1
                }
            }
            print("\"\(title)\" counted:")
            for (char, count) in charCount {
                print("\(char): \(count)")
            }
        }
    }
}
