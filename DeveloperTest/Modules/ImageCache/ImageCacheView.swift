//
//  ImageViewCache.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 28.04.2023.
//

import SwiftUI

struct ImageCacheView: View {
    
    @ObservedObject var viewModel: ImageCacheViewModel
    
    var body: some View {
        
        if (viewModel.image != nil) || (viewModel.errorImage != nil) {
            
            Image(uiImage: (viewModel.image ?? viewModel.errorImage)!)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
