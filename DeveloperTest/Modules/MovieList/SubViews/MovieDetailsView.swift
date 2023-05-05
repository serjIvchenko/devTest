//
//  MovieDetailsView.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 03.05.2023.
//

import Foundation
import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 5) {
            
            ImageCacheView(viewModel: .init(url: movie.image, errorImage: UIImage(systemName: "rays")))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .accessibilityIdentifier("MovieDetailsImage\(movie.rank)")
            
            VStack(alignment: .leading, spacing: 10.0) {
                
                Text(movie.title)
                    .font(.system(size: 20, weight: .bold))
                    .accessibilityIdentifier("MovieDetailsTitle\(movie.rank)")

                Text(movie.imDbRating)
                    .font(.system(size: 14))
                    .accessibilityIdentifier("MovieDetailsRating\(movie.rank)")
            }
        }
        .padding(10)
    }
}
