//
//  CustomIngredientsView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 23.03.2023.
//

import SwiftUI

struct CustomIngredientsView: View {
    @StateObject var ingredientsViewModel: IngredientsViewModel
    @State private var text = ""
    @State private var isEditing = false
    var body: some View {
        ZStack {
            Rectangle()
                .background(Color.black.opacity(0.5))
                .background(Color.blue.opacity(0.01))
                .background(.ultraThinMaterial.opacity(0.7))
                .environment(\.colorScheme, .light)
                .ignoresSafeArea()
            VStack {
                SearchView(text: $text, isEditing: $isEditing)
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("New ingredient")
                            .foregroundColor(Color("neonOrange"))
                    })
                    .padding(.leading, 8)
                    Spacer()
                }
                .padding()
                .padding(.bottom, -30)
                List {
                    ForEach(ingredientsViewModel.allIngredients, id: \.name) { ingredient in
                        Button {
                            
                        } label: {
                            Text(ingredient.name)
                                .foregroundColor(Color("neonOrange"))
                                .font(.system(size: 20))
                        }
                    }
                    .listRowBackground(Color(UIColor.darkGray).opacity(0.7))
                    
                }
                .scrollContentBackground(.hidden)
            }
        }
            .presentationDetents([.medium, .large])
            .background(Color.clear)
    }
}

struct CustomIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomIngredientsView(ingredientsViewModel: IngredientsViewModel(allIngredients: [IngredientDB(name: "xxx")]))
    }
}
