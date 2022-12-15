//
//  IngredientsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct IngredientsView: View {

    @StateObject var viewModel = CocktailsViewModel()

    var body: some View {
        Button("Fetch") {
            print("hi")
        }.onAppear {
            print("Get cocktails")
            self.viewModel.getCocktails()
        }
        .foregroundColor(Color.white)
        .frame(width: 200, height: 100)
        .background(Color.black)
        .cornerRadius(30)
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
