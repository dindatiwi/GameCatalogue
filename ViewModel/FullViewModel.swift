//
//  FullViewModel.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 05/09/21.
//

import SwiftUI
import Combine

class FullViewModel: ObservableObject {
    let key = "5c618ad1265d4be4bd482c6d4939ec92"
    @Published var getGames = [Games]()
    @Published var getDevDetail = [Developer]()
    var description: String = ""
    init() {
        let url = "https://api.rawg.io/api/games?key=\(key)"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if let error = err {
                print(error)
                return
            }
            guard let APIData = data else {
                print("no data found")
                return
            }
            do {
                let games = try JSONDecoder().decode(APIResult.self, from: APIData)
                DispatchQueue.main.async {
                    self.getGames = games.results
                }
            } catch {
                print(error)
            }
        }
        .resume()
    }
    func getGameDetail( gameId: Int) -> String {
        let url = URL(string: "https://api.rawg.io/api/games/\(gameId)?key=\(key)")
        URLSession.shared.dataTask(with: url!) { (data, response, _) in
            guard let response = response as? HTTPURLResponse, let data = data else { return }
            if response.statusCode == 200 {
                do {
                    let developers = try JSONDecoder().decode(GameDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.getDevDetail = developers.developers
                        self.description = developers.descriptionRaw
                    }
                } catch {
                    print(error)
                }
            } else {
                print("ERROR: \(data), HTTP Status: \(response.statusCode)")
            }
        }.resume()
        return description
    }
}
