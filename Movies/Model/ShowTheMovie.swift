//
//  ShowTheMovie.swift
//  Movies
//
//  Created by Yair Saucedo on 20/11/21.
//

import Foundation

struct Result:Codable {
    var page: Int
    var results: [ShowTheMovie]
}

struct ShowTheMovie: Codable {
    var adult: Bool
    var backdrop_path: String!
    var genre_ids: [Int]
    var id: Int32
    var original_language: String
    var overview: String
    var popularity: Double
    var poster_path: String!
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int32
    var category: String!
}

struct ShowTheMovie1: Codable {
    var favorite: Bool!
    var score: Double
    var show: ShowData
}

struct ShowData: Codable {
    var id: Int32
    var name: String
    var language: String
    var summary: String!
    var image: Image
    var rating: Rating
    var externals: Externals
}

struct Image: Codable {
    var medium: String
    var original: String
}

struct Rating: Codable {
    var average: Double
}

struct Externals: Codable {
    var imdb: String!
}

