//
//  DetailView.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 05/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    var games: Games
    var getID: Int
    @State private var showAlert = false
    @State private var isFavorite = false
    @State private var expanded: Bool = false
    @ObservedObject var fetchGameDetail = FullViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                WebImage(url: URL(string: games.image ?? ""))
                    .resizable()
                    .placeholder {
                        ProgressView()
                        .padding(.top, 20)}
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .aspectRatio(contentMode: .fill)
                VStack(alignment: .leading) {
                    Group {
                        Text(games.name)
                            .font(.title)
                            .fontWeight(.semibold)
                        HStack {
                            Text("Date Released : \(games.released ?? "")")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            HStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                Text(String(games.rating ?? 0.0))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Text("\(fetchGameDetail.getGameDetail(gameId: getID))")
                        .padding(.top, 10)
                        .font(.caption)
                        .lineLimit(self.expanded ? nil : 2)
                        .multilineTextAlignment(.leading)
                    Button(action: {
                        self.expanded.toggle()
                    }) {
                        Text(self.expanded ? "Show less" : "Show more").font(.system(size: 14, weight: .bold))
                    }

                    HStack(alignment: .top, spacing: 4) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Developers:").font(.headline)
                            ForEach(fetchGameDetail.getDevDetail) { dev in
                                Text("\(dev.name)").font(.system(size: 14))
                            }
                        }.frame(minWidth: 0, alignment: .leading)
                        Spacer()
                        VStack() {
                            Button(action: {
                                let gameProvider: FavoriteConfig = { return FavoriteConfig() }()
                                let id =  self.games.id
                                let name = "\(self.games.name)"
                                let descript = "\(self.fetchGameDetail.getGameDetail(gameId: self.getID))"
                                let released = "\(self.games.released!)"
                                let imageThumbnail = "\(self.games.image!)"
                                let rating = self.games.rating
                                if self.isFavorite == false {
                                    gameProvider.createMember(id,
                                                              name,
                                                              descript,
                                                              released,
                                                              imageThumbnail,
                                                              rating ?? 0.0) {
                                               DispatchQueue.main.async {
                                                self.isFavorite = true
                                               }
                                        self.showAlert = true
                                           }
                                } else {
                                    gameProvider.deleteMember(Int(id)) {
                                        DispatchQueue.main.async {
                                            self.isFavorite = false
                                        }
                                        self.showAlert = true
                                    }
                                }
                            }, label: {
                              if self.isFavorite {
                                Text("Favorited")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .background(Color.pink)
                                    .cornerRadius(19)
                              } else {
                                Text("Add to Favorite")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .background(Color.red.opacity(0.5))
                                    .cornerRadius(19)
                                }
                            })
                        }
                    }.alert(isPresented: $showAlert) {
                        var title: String = ""
                        var message: String = ""
                        if self.isFavorite != true {
                            title = "Game Dihapus dari Favorite"
                            message = "Game \(self.games.name) telah dihapus dari favorit Anda "
                        } else if self.isFavorite == true {
                            title = "Game Favorit Ditambah"
                            message = "Game \(self.games.name) successfully added to favorite"
                        }
                        return Alert(title: Text("\(title)"),
                                     message: Text("\(message)"),
                                     dismissButton: .default(Text("Okey!")))
                    }.padding(.top, 25)
                }.padding()
                Spacer()
            }
        }
        .onAppear {
            let gameProvider: FavoriteConfig = { return FavoriteConfig() }()
            gameProvider.getMember(self.games.id) { member in
                DispatchQueue.main.async {
                    if member.id != 0 {
                        self.isFavorite = true
                    } else {
                        self.isFavorite = false
                    }
                }
            }
        }
    }
}
