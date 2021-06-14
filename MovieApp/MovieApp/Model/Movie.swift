//
//  Movie.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import Foundation

struct Movie: Codable {
    var movieId: Int
    var title: String
    var overview: String
    var posterPath: String
    var voteAverage: Double
    var releaseDate: String
    var backDropPath: String
    var originalLanguage: String
    
    private enum CodingKeys : String, CodingKey {
        case movieId = "id"
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case backDropPath = "backdrop_path"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
    }
}

