//
//  Games.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 05/09/21.
//

import SwiftUI

struct APIResult: Codable {
    let results: [Games]
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct Games: Identifiable, Codable {
    let id: Int
    let name: String
    let released: String?
    let image: String?
    let rating: Double?
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case image = "background_image"
        case rating
    }
}
