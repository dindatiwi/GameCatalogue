//
//  AddFavorite.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 22/09/21.
//

import Foundation
class AddFavorite: ObservableObject {
    @Published var favoriteGamesData = [FavGameModel]()
    private var gameMember: [Favorite] = []
    private var gameMemberId: Int = 0
    private lazy var gameProvider: FavoriteConfig = { return FavoriteConfig() }()
    init() {
        self.gameProvider.getAllMember { (result) in
            DispatchQueue.main.async {
                self.favoriteGamesData = result
            }
        }
    }
    func fetchGameData() {
        self.gameProvider.getAllMember { (result) in
            DispatchQueue.main.async {
                self.favoriteGamesData = result
            }
        }
    }
}
