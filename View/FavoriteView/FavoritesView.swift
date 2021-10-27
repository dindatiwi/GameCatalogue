//
//  FavoritesView.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 22/09/21.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        GameFavoriteList()
    }
}

struct GameFavoriteList: View {
    @ObservedObject var fetchData = AddFavorite()
    var body: some View {
        NavigationView {
            listGameView
                .navigationTitle(Text("Favorite Game"))
                .onAppear {
                    self.fetchData.fetchGameData()
                }
        }
    }
    var listGameView: AnyView {
        if self.fetchData.favoriteGamesData.isEmpty {
            return AnyView(emptyGameList)
        } else {
            return AnyView(faveGameLists)
        }
    }
    var emptyGameList: some View {
        Text("No Favorited Game Added Yet")
    }
    var faveGameLists: some View {
        List(fetchData.favoriteGamesData) { fav in
            ZStack(alignment: .leading) {
                NavigationLink(destination: FaveDetailView(games: fav)) {
                    EmptyView()
                }   .opacity(0.0)
                .buttonStyle(PlainButtonStyle())
                FaveRowView(games: fav)
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
