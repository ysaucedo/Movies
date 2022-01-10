//
//  Video.swift
//  Movies
//
//  Created by Yair Saucedo on 21/11/21.
//

import Foundation

struct ResultVideo:Codable {
    var id: Int32
    var results: [Video]
}

struct Video: Codable {
    var iso_639_1: String
    var iso_3166_1: String
    var name: String
    var key: String
    var site: String
    var size: Int32
    var type: String
    var official: Bool
    var published_at: String
    var id: String
}
