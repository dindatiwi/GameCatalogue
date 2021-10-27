//
//  Developer.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 21/09/21.
//

import Foundation
struct Developer: Codable, Identifiable {
    var id: Int
    var name: String
    var gamesCount: Int
    var imageBackground: String
    enum CodingKeys: String, CodingKey {
          case id
          case name
          case gamesCount = "games_count"
          case imageBackground = "image_background"
      }
}
