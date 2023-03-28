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
    @Binding var namesIngredients: [String]
    let action: () -> Void
    let actionTwo: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(Color.black.opacity(0.5))
                .background(Color.blue.opacity(0.01))
                .background(.ultraThinMaterial.opacity(0.7))
                .environment(\.colorScheme, .light)
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: 40)
                SearchView(text: $text, isEditing: $isEditing)
                    
                HStack {
                    Button(action: {
                        action()
                    }, label: {
                        Text("New ingredient")
                            .foregroundColor(Color("neonBlue"))
                    })
                    .padding(.leading, 8)
                    Spacer()
                }
                .padding()
                .padding(.bottom, -30)
                List {
                    ForEach(ingredientsViewModel.allIngredients, id: \.name) { ingredient in
                        Button {
                            actionTwo()
                            namesIngredients.append(ingredient.name)
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
            .onAppear{
                ingredientsViewModel.getIngredients()
            }
    }
}

struct CustomIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomIngredientsView(ingredientsViewModel: IngredientsViewModel(allIngredients: [IngredientDB(name: "xxx")]), namesIngredients: .constant([""]), action: {}, actionTwo: {})
    }
}
