//
//  DeveloperTestApp.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 28.04.2023.
//

import SwiftUI

@main
struct RootView: App {
    
    @ObservedObject private var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: .init(router: router))
        }
    }
}
