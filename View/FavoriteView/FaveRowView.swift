//
//  FaveRowView.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 22/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FaveRowView: View {
    var games: FavGameModel
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            WebImage(url: URL(string: games.gameImageThumbnail ?? ""))
                .resizable()
                .placeholder {
                    ProgressView()
                    .padding(.top, 20)}
                .frame(width: 150, height: 100)
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 8) {
                Text(games.gameName ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(games.gameReleasedDate ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text(String(games.gameRating ?? 0.0))
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
