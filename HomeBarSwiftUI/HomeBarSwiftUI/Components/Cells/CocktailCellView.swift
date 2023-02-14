//
//  CocktailCellView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct CocktailCellView: View {

    var cocktail: CocktailDB

    var body: some View {
        VStack(spacing: 5) {
            Text(cocktail.name)
                .foregroundColor(Color("neonBlue"))
            HStack(spacing: 5) {
                Image(cocktail.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: screen.width * 0.2)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Favorite: \(cocktail.numberOfRatings)")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                    Text("Rating: \(lround(cocktail.rating))")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                    Text("Type: \(cocktail.alcoholic)")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                }
            }
        }
        .padding(5)
        .background(Color(.gray).opacity(0.2))
        .cornerRadius(20)

        .frame(width: screen.width * 0.55, height: screen.height * 0.15, alignment: .center)
    }
}

struct CocktailCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WallpaperView()
            CocktailCellView(cocktail: CocktailDB(name: "White Russian", tags: "Cocktail", alcoholic: "Alcoholic", instructions: "shake in glass", image: "whiteRussian", ingredients: ["vodka":"50", "crema": "50", "kaluha": "50"], rating: 5.0, numberOfRatings: 5, sumOfRating: 5.0, userRating: 5.0, likes: 13, comments: ["user": "ilia", "title": "good drink", "text": "my favorite"]))
        }
    }
}
