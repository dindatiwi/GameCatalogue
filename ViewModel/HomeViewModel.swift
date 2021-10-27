//
//  HomeViewModel.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 05/09/21.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    @Published var searchQuery = ""
    var searchCancellable: AnyCancellable? = nil
    @Published var fetchedGames: [Games]? = nil
    var appError: AppError? = nil
    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    self.fetchedGames = nil
                } else {
                    self.searchGames()
                }
            })
    }

    func searchGames() {
        let originQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "https://api.rawg.io/api/games?search=\(originQuery)&key=5c618ad1265d4be4bd482c6d4939ec92"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            if let error = error {
                self.appError = AppError(errorString: error.localizedDescription)
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
                    if self.fetchedGames == nil {
                        self.fetchedGames = games.results
                    }
                }
            } catch {
                self.appError = AppError(errorString: error.localizedDescription)
                print(error)
            }
        }
        .resume()
    }
}
