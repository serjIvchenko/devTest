//
//  Movie.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 28.04.2023.
//

import Foundation

struct MovieFeedResult: Codable {
    let items: [Movie]
}

struct Movie: Codable, Identifiable, Hashable {
    let id: String
    let rank: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
    let imDbRating: String
    let imDbRatingCount: String
}

//struct MovieFeedResult: Codable {
//    let results: [Movie]
//}
//
//struct Movie: Codable, Identifiable, Hashable {
//
//    let id: Int
//    let title: String
//    var overview: String?
//    var posterPath: String?
//    var backdropPath: String?
//    var releaseDate: String?
//
//    enum CodingKeys: String, CodingKey {
//        case posterPath = "poster_path"
//        case backdropPath = "backdrop_path"
//        case releaseDate = "release_date"
//        case id
//        case title
//        case overview
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
//        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
//        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
//        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
//        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
//        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
//    }
//}
