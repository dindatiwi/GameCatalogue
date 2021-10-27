//
//  Home.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 05/09/21.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    @StateObject var favData = AddFavorite()
    var body: some View {
        TabView {
            GamesView()
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("Games")
                }
                .environmentObject(homeData)
            FavoritesView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Favorites")
                }
                .environmentObject(favData)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }.accentColor(.blue)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
