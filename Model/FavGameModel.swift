//
//  FavGameModel.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 22/09/21.
//

import Foundation
struct FavGameModel: Codable, Identifiable {
    var id: Int?
    var gameName: String?
    var gameDescription: String?
    var gameReleasedDate: String?
    var gameImageThumbnail: String?
    var gameRating: Double?
}
