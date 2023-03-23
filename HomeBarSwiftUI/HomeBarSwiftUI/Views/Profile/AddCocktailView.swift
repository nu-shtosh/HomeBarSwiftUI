//
//  AddCocktailView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 23.03.2023.
//

import SwiftUI

struct AddCocktailView: View {
    @StateObject var ingredientsViewModel: IngredientsViewModel
    @State var text = ""
    @State var isPresent = false
    @State var ingredientsTextfield = [""]
    @State var ingredientsText = [""]
    @State var nameIngredient = ""
    @State var nameButton = "Mesure"
    private let measures = ["ml", "oz"]
    
    var body: some View {
        ZStack {
            WallpaperView()
            ScrollView(.vertical, showsIndicators: false){
                Image("pinaColada")
                    .resizable()
                    .foregroundColor(Color("neonOrange"))
                    .frame(width: 200, height: 200)
                HStack {
                    Text("Name cocktail")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                    Spacer()
                }
                TextFieldWithImageView(title: "Name cocktail", imageSystemName: "", text: $text)
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
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color("neonBlue"))
                    }
                    .padding(.trailing, 16)
                }
              
                ForEach(ingredientsTextfield.indices, id: \.self) { index in
                    if index > 0 {
                        HStack {
                            TextField("name", text: $ingredientsTextfield[index])
                                .textFieldStyle(GradientTextFieldBackground())
                                .padding(.leading, 16)
                                .padding(.trailing, 16)
                            NumberTextFieldView(
                                text: $text,
                                label: nameButton,
                                sizeWidth: 71,
                                sizeHeight: 40,
                                maxValue: 1000
                            )
                            Menu(nameButton) {
                                Button("ml", action: {
                                    nameButton = "ml"
                                })
                                Button("oz", action: {
                                    nameButton = "oz"
                                })
                                Button("tsp", action: {
                                    nameButton = "tsp"
                                })
                                Button("tblsp", action: {
                                    nameButton = "tblsp"
                                })
                                Button("dashes", action: {
                                    nameButton = "dashes"
                                })
                                Button("cube", action: {
                                    nameButton = "cube"
                                })
                                Button("pieces", action: {
                                    nameButton = "pieces"
                                })
                                Button("splash", action: {
                                    nameButton = "splash"
                                })
                            }
                            .padding(.trailing, 8)
                            Button {
                                ingredientsTextfield.remove(at: index)
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .frame(width: 30, height: 4)
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
                              Text(nameIngredient)
                                  .padding(.leading, 16)
                                  .padding(.trailing, 16)
                              NumberTextFieldView(
                                  text: $text,
                                  label: nameButton,
                                  sizeWidth: 71,
                                  sizeHeight: 40,
                                  maxValue: 1000
                              )
                              Menu(nameButton) {
                                  Button("ml", action: {
                                      nameButton = "ml"
                                  })
                                  Button("oz", action: {
                                      nameButton = "oz"
                                  })
                                  Button("tsp", action: {
                                      nameButton = "tsp"
                                  })
                                  Button("tblsp", action: {
                                      nameButton = "tblsp"
                                  })
                                  Button("dashes", action: {
                                      nameButton = "dashes"
                                  })
                                  Button("cube", action: {
                                      nameButton = "cube"
                                  })
                                  Button("pieces", action: {
                                      nameButton = "pieces"
                                  })
                                  Button("splash", action: {
                                      nameButton = "splash"
                                  })
                              }
                              .padding(.trailing, 8)
                              Button {
                                  ingredientsTextfield.remove(at: index)
                              } label: {
                                  Image(systemName: "minus")
                                      .resizable()
                                      .frame(width: 30, height: 4)
                                      .foregroundColor(Color("neonBlue"))
                              }
                              .padding(.trailing, 16)

                              
                          }
                      }
                  }
                HStack {
                    Text("Recipt")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                    Spacer()
                }
                TextEditor(text: $text)
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
            CustomIngredientsView(ingredientsViewModel: ingredientsViewModel, nameIngredient: $nameIngredient, action: appendTextfield)
        }
       
    }
    
    private func appendTextfield() {
        ingredientsTextfield.append("1")
    }
}

struct AddCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCocktailView(ingredientsViewModel: IngredientsViewModel(allIngredients: [IngredientDB(name: "xxx")]))
    }
}
