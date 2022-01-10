//
//  ShowTheMovie.swift
//  Movies
//
//  Created by Yair Saucedo on 20/11/21.
//

import Foundation

struct ResultSerie:Codable {
    var page: Int
    var results: [SerieTheMovie]
}

struct SerieTheMovie: Codable {
    var backdrop_path: String!
    var category: String!
    var first_air_date: String!
    var id: Int32
    var name: String
    var original_language: String
    var original_name: String
    var overview: String
    var popularity: Double
    var poster_path: String!
    var vote_average: Double
    var vote_count: Int32
}
