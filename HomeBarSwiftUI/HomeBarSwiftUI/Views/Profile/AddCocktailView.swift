//
//  AddCocktailView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 23.03.2023.
//

import SwiftUI

struct AddCocktailView: View {
    @StateObject var ingredientsViewModel: IngredientsViewModel
    @State var receptText = ""
    @State var isPresent = false
    @State var ingredientsTextfield = [""]
    @State var ingredientsText = [""]
    @State var measureTextfield = [""]
    @State var measureText = [""]
    @State var nameCocktail = ""
    @State var nameButtonTextfield = [""]
    @State var nameButtonText = [""]
    private let measures = ["ml", "oz", "tsp", "tblsp", "dashes", "cube", "pieces", "splash"]
    
    var body: some View {
        ZStack {
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false){
                Image("pinaColada")
                    .resizable()
                    .frame(width: 200, height: 200)
                HStack {
                    Text("Name cocktail")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                    Spacer()
                }
                TextFieldWithImageView(title: "Name cocktail", imageSystemName: "", text: $nameCocktail)
                    .padding()
                HStack {
                    Text("Ingredients")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                    Spacer()
                    Button {
                        isPresent.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("neonBlue"))
                    }
                    .padding(.trailing, 16)
                }
                
                ForEach(ingredientsTextfield.indices, id: \.self) { index in
                    if index > 0 {
                        HStack {
                            DefaultTextFieldView(
                                title: "name",
                                text: $ingredientsTextfield[index],
                                sizeWidth: nil,
                                sizeHeight: 40
                            )
                            .padding(.leading, 16)
                            Spacer()
                            DefaultTextFieldView(
                                title: "measure",
                                text: $measureTextfield[index],
                                sizeWidth: 60,
                                sizeHeight: 40
                            )
                            
                            Menu(nameButtonTextfield[index]) {
                                ForEach(measures, id: \.self) { measure in
                                    Button(measure) {
                                        nameButtonTextfield[index] = measure
                                    }
                                }
                            }
                            .frame(width: 65)
                            .padding(.trailing, 8)
                            Button {
                                
                                ingredientsTextfield.remove(at: index)
                                nameButtonTextfield.remove(at: index)
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .frame(width: 25, height: 3.5)
                                    .foregroundColor(Color("neonBlue"))
                            }
                            .padding(.trailing, 16)
                        }
                    }
                }
                .padding(.bottom, 8)
                ForEach(ingredientsText.indices, id: \.self) { index in
                    if index > 0 {
                        HStack {
                            Text(ingredientsText[index])
                                .padding(.leading, 16)
                            Spacer()
                            DefaultTextFieldView(
                                title: "measure",
                                text: $measureText[index],
                                sizeWidth: 60,
                                sizeHeight: 40
                            )
                            
                            Menu(nameButtonText[index]) {
                                ForEach(measures, id: \.self) { measure in
                                    Button(measure) {
                                        nameButtonText[index] = measure
                                    }
                                }
                            }
                            .frame(width: 65)
                            .padding(.trailing, 8)
                            Button {
                                ingredientsText.remove(at: index)
                                nameButtonText.remove(at: index)
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .frame(width: 25, height: 3.5)
                                    .foregroundColor(Color("neonBlue"))
                            }
                            .padding(.trailing, 16)
                        }
                    }
                }
                HStack {
                    Text("Recept")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                    Spacer()
                }
                TextEditor(text: $receptText)
                    .foregroundColor(.black)
                    .scrollContentBackground(.hidden)
                    .background(Color.white.opacity(0.8))
                    .border(LinearGradient(
                        colors: [
                            Color("neonOrange"),
                            Color("neonBlue")
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .cornerRadius(8)
                    .padding()
                    .frame(minHeight: 73, maxHeight: 1000, alignment: .center)
                Button {
                    
                } label: {
                    Text("Save")
                }
            }
        }
        .sheet(isPresented: $isPresent) {
            CustomIngredientsView(
                ingredientsViewModel: ingredientsViewModel,
                namesIngredients: $ingredientsText,
                action: appendTextfield,
                actionTwo: appendText
            )
        }
        
    }
    
    private func appendTextfield() {
        ingredientsTextfield.append("")
        measureTextfield.append("")
        nameButtonTextfield.append("Mesure")
        
    }
    
    private func appendText() {
        measureText.append("")
        nameButtonText.append("Mesure")
    }
    
    
}

struct AddCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCocktailView(ingredientsViewModel: IngredientsViewModel(allIngredients: [IngredientDB(name: "xxx")]))
    }
}
