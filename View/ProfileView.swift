//
//  ProfileView.swift
//  testAPIMarvelApp
//
//  Created by adinda pratiwi prameswari on 05/09/21.
//

import SwiftUI

struct ProfileView: View {
    var adaptiveWidth = UIScreen.main.bounds.size.width * 0.900
    var adaptiveHeight = UIScreen.main.bounds.size.height * 0.300
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .frame(width: adaptiveWidth, height: adaptiveHeight)
                    .foregroundColor(.gray)
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .clipShape(Circle())
            }
            Text("Adinda Pratiwi Prameswari")
                .font(.title)
                .fontWeight(.semibold)
            Text("Beginner iOS Developer")
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
