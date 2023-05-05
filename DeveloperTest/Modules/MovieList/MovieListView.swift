//
//  MovieListView.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 01.05.2023.
//

import SwiftUI

struct MovieListView: View {
    
    @StateObject var viewModel: MovieListViewModel
    
    var body: some View {
        
        NavigationStack(path: $viewModel.router.path) {
            contentView
                .refreshable {
                    viewModel.loadMovie()
                }
                .transition(.opacity)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .movieDetails(let movie):
                        viewModel.goToMovieDetails(movie: movie)
                    }
                }
        }
    }
    
    @ViewBuilder private var contentView: some View {
        switch viewModel.state {
        case .loaded:
            List(viewModel.movies) { movie in
                
                MovieCellView(movie: movie)
                    .onTapGesture {
                        viewModel.setPathToMovieDetails(movie: movie)
                    }
            }
        case .loading:
            ProgressView()
        }
    }
}

#if DEBUG
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: .init(router: Router()))
    }
}
#endif
