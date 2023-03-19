//
//  CocktailDetailView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct CocktailDetailView: View {
    
    var cocktail: CocktailDB
    @State private var image = Data()
    
    var ingredientsCount: Int {
        cocktail.ingredients.count
    }
    
    var body: some View {
        // Helpers For Ingredients List
        let ingredientsNames = cocktail.ingredients.keys.map { $0 }
        let ingredientsMeasures = cocktail.ingredients.values.map { $0 }
        
        ZStack {
            WallpaperView()
            ScrollView {
                VStack(spacing: 10) {
                    // MARK: - Cocktail Image
                    VStack {
                        Image(uiImage: UIImage(data: image) ?? UIImage(named: "pinaColada")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                                colors: [Color("neonBlue"), Color("neonOrange")],
                                startPoint: .top,
                                endPoint: .bottom
                            ).opacity(0.3), lineWidth: 2))
                            .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                                       startPoint: .top,
                                                       endPoint: .bottom).opacity(0.15))
                            .cornerRadius(16)
                    }
                    
                    // MARK: - Cocktail Social (Rating, Likes)
                    VStack {
                        HStack {
                            Text("Social")
                                .foregroundColor(.gray)
                                .font(.callout)
                                .bold()
                                .padding(.leading)
                            Spacer()
                        }
                        VStack {
                            HStack {
                                Text("Rating:")
                                    .foregroundColor(Color("neonOrange"))
                                Spacer()
                                Text("\(cocktail.rating.description)")
                                    .foregroundColor(Color("neonBlue"))
                            }
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color("neonBlue").opacity(0.3))
                            
                            HStack {
                                Text("Likes:")
                                    .foregroundColor(Color("neonOrange"))
                                Spacer()
                                Text("\(cocktail.likes.description)")
                                    .foregroundColor(Color("neonBlue"))
                            }
                            
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                            colors: [Color("neonBlue"), Color("neonOrange")],
                            startPoint: .top,
                            endPoint: .bottom
                        ).opacity(0.3), lineWidth: 2))
                        .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                                   startPoint: .top,
                                                   endPoint: .bottom).opacity(0.15))
                        .cornerRadius(16)
                    }
                    
                    // MARK: - Cocktail Ingredients
                    VStack {
                        HStack {
                            Text("Ingredients")
                                .foregroundColor(.gray)
                                .padding(.leading)
                                .font(.callout)
                                .bold()
                            Spacer()
                        }
                        VStack {
                            ForEach(cocktail.ingredients.keys.enumerated().sorted(by: <), id: \.element) { index, _ in
                                HStack() {
                                    Text(ingredientsNames[index]).foregroundColor(Color("neonOrange"))
                                    Spacer()
                                    Text(ingredientsMeasures[index]).foregroundColor(Color("neonBlue"))
                                }
                                if index < (cocktail.ingredients.count - 1) {
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color("neonBlue").opacity(0.3))
                                }
                            }
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                            colors: [Color("neonBlue"), Color("neonOrange")],
                            startPoint: .top,
                            endPoint: .bottom
                        ).opacity(0.3), lineWidth: 2))
                        .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                                   startPoint: .top,
                                                   endPoint: .bottom).opacity(0.15))
                        .cornerRadius(16)
                    }
                    
                    // MARK: - Cocktail Recipe/Instruction
                    VStack {
                        HStack {
                            Text("Recipe")
                                .foregroundColor(.gray)
                                .padding(.leading)
                                .font(.callout)
                                .bold()
                            Spacer()
                        }
                        VStack {
                            Text(cocktail.instructions)
                                .foregroundColor(Color("neonOrange"))
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                                    colors: [Color("neonBlue"), Color("neonOrange")],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ).opacity(0.3), lineWidth: 2))
                                .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                                           startPoint: .top,
                                                           endPoint: .bottom).opacity(0.15))
                                .cornerRadius(16)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.hidden, for: .tabBar)
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

//struct CocktailDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            WallpaperView()
//            CocktailDetailView(cocktail: CocktailDB(name: "White Russian", tags: "Cocktail", alcoholic: "Alcoholic", instructions: "shake in glass", image: "whiteRussian", ingredients: ["vodka":"50", "crema": "50", "kaluha": "50"], rating: 5.0, numberOfRatings: 5, sumOfRating: 5.0, userRating: 5.0, likes: 13, comments: ["user": "ilia", "title": "good drink", "text": "my favorite"]))
//        }
//    }
//}
