//
//  GameDetail.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 21/09/21.
//

import Foundation
struct GameDetail: Codable {
    let descriptionRaw: String
    let id: Int
    let developers: [Developer]
    enum CodingKeys: String, CodingKey {
           case descriptionRaw = "description_raw"
           case id = "id"
           case developers = "developers"
    }
}
