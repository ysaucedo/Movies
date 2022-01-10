//
//  URL+PropertyListDecoder.swift
//
//

import Foundation

extension URL {

    func decodePropertyList<T: Decodable>() throws -> T {
        let data = try Data(contentsOf: self)
        let decoder = PropertyListDecoder()
        return try decoder.decode(T.self, from: data)
    }

}
