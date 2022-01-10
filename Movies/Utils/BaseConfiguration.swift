//
//  BaseConfiguration.swift
//
//

struct BaseConfiguration: Decodable {

    struct Keys: Decodable {

        let url: String
        let apiKey: String

        private enum CodingKeys: String, CodingKey {
            case url = "url"
            case apiKey = "ApiKey"
        }

    }

    let keys: Keys

    private enum CodingKeys: String, CodingKey {
        case keys = "TheMovieDB"
    }

}
