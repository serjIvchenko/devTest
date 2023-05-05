//
//  NetworkLayer.swift
//  DeveloperTest
//
//  Created by sergey ivchenko on 02.05.2023.
//

import Foundation
import Combine

enum Error: LocalizedError {
    
    case addressUnreachable(URL)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server"
        case .addressUnreachable(let url):
            return "Unreachable URL: \(url.absoluteString)"
        }
    }
}

struct API {
    
    enum EndPoint {
        static let baseURL = URL(string: "https://imdb-api.com")!//URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=34a92f7d77a168fdcd9a46ee1863edf1")!
        static let apiKey = "k_rqnewns3"
        
        case topRated
        case search(String)
        
        var url: URL {
            switch self {
            case .topRated:
                return  EndPoint.baseURL.appendingPathComponent("/en/API/Top250Movies/\(API.EndPoint.apiKey)") 
            case .search(let movieName):
                return EndPoint.baseURL.appendingPathComponent("/en/API/SearchMovie/\(API.EndPoint.apiKey)/\(movieName)")
            }
        }
    }
    
    private let decoder = JSONDecoder()
    private let apiQueue = DispatchQueue(label: "IMDB-API",
                                         qos: .background,
                                         attributes: .concurrent)
    
    func topRatedMovie() -> AnyPublisher<MovieFeedResult, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.topRated.url)
            .receive(on: apiQueue)
            .map(\.data)
            .decode(type: MovieFeedResult.self, decoder: decoder)
            .catch { _ in Empty<MovieFeedResult, Error>() }
            .eraseToAnyPublisher()
    }
    
    func movieSearch(_ movieName: String) -> AnyPublisher<MovieFeedResult, Error> {
        URLSession.shared
            .dataTaskPublisher(for: EndPoint.search(movieName).url)
            .map(\.data)
            .decode(type: MovieFeedResult.self, decoder: decoder)
            .mapError { (error) -> Error in
                switch error {
                case is URLError:
                    return Error.addressUnreachable(EndPoint.search(movieName).url)
                default:
                    return Error.invalidResponse
                }
            }
            .eraseToAnyPublisher()
    }
}
