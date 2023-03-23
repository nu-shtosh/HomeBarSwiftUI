//
//  AllIngredientsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 22.03.2023.
//

import SwiftUI

struct AllIngredientsView: View {

    @StateObject var ingredientsViewModel: IngredientsViewModel

    var body: some View {
        ZStack() {
            WallpaperView()
            VStack {
                ForEach(ingredientsViewModel.allIngredients, id: \.name) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .foregroundColor(Color("neonOrange"))
                        Spacer()
                    }
                    if ingredient != ingredientsViewModel.allIngredients.last {
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
            .onAppear{
                ingredientsViewModel.getIngredients()
            }
            Spacer()
        }
        .navigationTitle("Ingredients")
        .navigationBarTitleDisplayMode(.large)
    }
}
