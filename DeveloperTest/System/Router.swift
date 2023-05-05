//
//  Router.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 03.05.2023.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case movieDetails(movie: Movie)
}

final class Router: ObservableObject {
    
    static let shared = Router()
    
    @Published var path = [Route]()
    private let fabric: RouterFabric
    
    init() {
        self.fabric = RouterFabric()
    }
}

extension Router {
    
    func push(to view: Route) {
        path.append(view)
    }
    
    func goToMovieDetails(movie: Movie) -> MovieDetailsView {
        return fabric.buildMovieDetails(movie: movie)
    }
    
}

struct RouterFabric {
    
    func buildMovieDetails(movie: Movie) -> MovieDetailsView {
        return MovieDetailsView(movie: movie)
    }
    
}
