//
//  CocktailDetailView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct CocktailDetailView: View {

    var cocktail: CocktailDB
    @State var image = Data()


    var body: some View {
            ZStack {
                WallpaperView()
                ScrollView {
                    VStack {
                        HStack {
                            Image(uiImage: UIImage(data: image) ?? UIImage(named: "pinaColada")!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(20)
                        }
                        .padding()
                        .background(.white.opacity(0.1))
                        .cornerRadius(20)
                        .padding()

                        HStack {
                            Text("\(cocktail.instructions)")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(.white.opacity(0.1))
                        .cornerRadius(20)
                        .padding()

                        Spacer()

                    }
                }
            }
            .onAppear {
                getImage(imageURL: cocktail.image)
            }
    }

    func getImage(imageURL: String) {
            NetworkManager.shared.fetchImage(from: imageURL) { result in
                switch result {
                case .success(let images):
                    image = images
                case .failure(let error):
                    print(error.localizedDescription)
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
