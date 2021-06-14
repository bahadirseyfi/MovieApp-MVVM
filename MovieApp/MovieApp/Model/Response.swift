//
//  Response.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import Foundation

struct MoviesResponse: Codable {
    var results: [Movie]
}

struct CreditsResponse: Codable {
    var results: [Cast]
}
