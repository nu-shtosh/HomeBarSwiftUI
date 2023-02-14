//
//  CocktailDetailView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct CocktailDetailView: View {

    var cocktail: CocktailDB

    var body: some View {
        ZStack {
            WallpaperView()
            VStack{
                Text("\(cocktail.name)")
                Text("\(cocktail.instructions)")
            }
        }
    }
}

struct CocktailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WallpaperView()
            CocktailDetailView(cocktail: CocktailDB(name: "White Russian", tags: "Cocktail", alcoholic: "Alcoholic", instructions: "shake in glass", image: "whiteRussian", ingredients: ["vodka":"50", "crema": "50", "kaluha": "50"], rating: 5.0, numberOfRatings: 5, sumOfRating: 5.0, userRating: 5.0, likes: 13, comments: ["user": "ilia", "title": "good drink", "text": "my favorite"]))
        }
    }
}
