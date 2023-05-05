//
//  MovieCellView.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 28.04.2023.
//

import SwiftUI
import Combine

struct MovieCellView: View {
    
    let movie: Movie
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 20) {
            
            ImageCacheView(viewModel: .init(url: movie.image, errorImage: UIImage(systemName: "rays")))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(width: 100, height: 150)
                .accessibilityIdentifier("ImageCache\(movie.rank)")
            
            VStack(alignment: .leading, spacing: 10.0) {
                
                Text(movie.title)
                    .font(.system(size: 20, weight: .bold))
                    .accessibilityIdentifier("MovieCellTitle\(movie.rank)")
                Text(movie.rank)
                    .font(.system(size: 16))
                    .accessibilityIdentifier("MovieCellRank\(movie.rank)")
            }
        }
    }
}
