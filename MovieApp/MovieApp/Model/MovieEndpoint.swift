//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import Foundation
import API

enum MovieEndpoint: Endpoint {
    
    case nowPlaying
    case topRated
    case popular
    case detail(id: Int)
    case credits(id: Int)
    
    var baseURL: String { MovieDBBaseAPI.BaseURL }
    
    var baseApiVersion: String { MovieDBBaseAPI.BaseAPIVersion }
    var conjunction: String { "movie/" }
    var key: String { MovieDBBaseAPI.TheMovieDBAPIKey }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .detail(let id):
            return "\(id)"
        case .credits(let id):
            return "\(id)/credits"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .nowPlaying: return .get
            case .popular: return .get
            case .topRated: return .get
            case .detail: return .get
            case .credits: return .get
        }
    }
}
