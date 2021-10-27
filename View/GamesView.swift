//
//  GamesView.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 05/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GamesView: View {
    @ObservedObject var homeData = HomeViewModel()
    @ObservedObject var fetch = FullViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search Game Here", text: $homeData.searchQuery)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                Spacer()
                if let games = homeData.fetchedGames {
                    List(games) { data in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: DetailView(games: data, getID: data.id) ) {
                                EmptyView()
                            }   .opacity(0.0)
                            .buttonStyle(PlainButtonStyle())
                            GamesRowView(games: data)
                        }
                    }
                    .alert(item: $homeData.appError) { appAlert in
                        Alert(title: Text("Error"), message: Text("\(appAlert.errorString)"))
                    }
                } else {
                    if homeData.searchQuery != "" {
                        ProgressView()
                            .padding(.top, 20)
                    } else {
                        if fetch.getGames.isEmpty {
                            ProgressView()
                                .padding(.top, 20)
                        } else {
                            List(fetch.getGames) { games in
                                ZStack(alignment: .leading) {
                                    NavigationLink(destination: DetailView(games: games, getID: games.id) ) {
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                    GamesRowView(games: games)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Games")
        }
    }
}
struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GamesRowView: View {
    var games: Games
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            WebImage(url: URL(string: games.image ?? ""))
                .resizable()
                .placeholder {
                    ProgressView()
                    .padding(.top, 20)}
                .frame(width: 150, height: 100)
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 8) {
                Text(games.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(games.released ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text(String(games.rating ?? 0.0))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
            }
            Spacer()
        }
    }
}
