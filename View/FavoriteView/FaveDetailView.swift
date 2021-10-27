//
//  FaveDetailView.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 22/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FaveDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var games: FavGameModel
    @State private var showAlert = false
    @State private var expanded: Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                WebImage(url: URL(string: games.gameImageThumbnail ?? ""))
                    .resizable()
                    .placeholder {
                        ProgressView()
                        .padding(.top, 20)}
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .aspectRatio(contentMode: .fill)
                VStack(alignment: .leading) {
                    Group {
                        Text(games.gameName ?? "")
                            .font(.title)
                            .fontWeight(.semibold)
                        HStack {
                            Text("Date Released : \(games.gameReleasedDate ?? "")")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            HStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                Text(String(games.gameRating ?? 0.0))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Text("\(games.gameDescription ?? "")")
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
                        VStack(spacing: 5) {
                            Button(action: {
                                        self.showAlert = true
                            }, label: {
                                Text("Favorited")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 20)
                                    .background(Color.pink)
                                    .cornerRadius(19)
                            })
                        }
                    }.alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you Sure?"),
                            message: Text("Are you sure to remove this game from favorite?"),
                            primaryButton: .destructive(Text("Ya"), action: {
                                let gameId = self.games.id
                                let memberProvider: FavoriteConfig = { return FavoriteConfig() }()
                                memberProvider.deleteMember(Int(gameId ?? 0)) {
                                    DispatchQueue.main.async {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                            }
                            ),
                            secondaryButton: Alert.Button.cancel(Text("No"))
                        )
                    }.padding(.top, 25)
                }.padding()
                Spacer()
            }
        }
    }
}
