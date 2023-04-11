//
//  AddCocktailView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 23.03.2023.
//

import SwiftUI

struct AddCocktailView: View {
    @StateObject var ingredientsViewModel: IngredientsViewModel
    @StateObject var cocktailsViewModel: CocktailsViewModel
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
    @State private var showImagePicker = false
    @State private var showProgressView = false
    @State var image = UIImage(named: "pinaColada")!
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ZStack {
                WallpaperView()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        // MARK: image cocktail
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width:
                                    withAnimation{
                                        image != UIImage(named: "pinaColada") ? screen.width - 32 : 200
                                    },
                                height:
                                    withAnimation{
                                        image != UIImage(named: "pinaColada") ? screen.width - 32 : 200
                                        
                                    }
                            )
                        
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                                colors: [Color("neonBlue"), Color("neonOrange")],
                                startPoint: .top,
                                endPoint: .bottom
                            ).opacity(0.3), lineWidth: 2))
                            .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                                       startPoint: .top,
                                                       endPoint: .bottom).opacity(0.15))
                            .cornerRadius(16)
                            .onTapGesture {
                                showImagePicker.toggle()
                            }
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(
                                    sourceType: .photoLibrary,
                                    selected: $image
                                )
                            }
                        // MARK: End image cocktail
                    }
                    .padding()
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
                                    sizeWidth: 70,
                                    sizeHeight: 40
                                )
                                
                                Menu(nameButtonTextfield[index]) {
                                    ForEach(measures, id: \.self) { measure in
                                        Button(measure) {
                                            nameButtonTextfield[index] = measure
                                        }
                                    }
                                }
                                .foregroundColor(Color("neonBlue"))
                                .frame(width: 65)
                                .padding(.trailing, 8)
                                Button {
                                    ingredientsTextfield.remove(at: index)
                                    nameButtonTextfield.remove(at: index)
                                    measureTextfield.remove(at: index)
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
                                    .foregroundColor(Color("neonOrange"))
                                Spacer()
                                DefaultTextFieldView(
                                    title: "measure",
                                    text: $measureText[index],
                                    sizeWidth: 70,
                                    sizeHeight: 40
                                )
                                
                                Menu(nameButtonText[index]) {
                                    ForEach(measures, id: \.self) { measure in
                                        Button(measure) {
                                            nameButtonText[index] = measure
                                        }
                                    }
                                }
                                .foregroundColor(Color("neonBlue"))
                                .frame(width: 65)
                                .padding(.trailing, 6)
                                Button {
                                    ingredientsText.remove(at: index)
                                    nameButtonText.remove(at: index)
                                    measureText.remove(at: index)
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
                        showProgressView = true
                        uploadData()
                    } label: {
                        Text("Save")
                    }
                }

            }
            .disabled(showProgressView)
            .blur(radius: showProgressView ? 3 : 0)
            .sheet(isPresented: $isPresent) {
                CustomIngredientsView(
                    ingredientsViewModel: ingredientsViewModel,
                    namesIngredients: $ingredientsText,
                    action: appendTextfield,
                    actionTwo: appendText
                )
            }
            if showProgressView {
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("neonBlue"))
            }
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
    
    private func configureCocktail() -> CocktailDB {
        cocktailsViewModel.cocktail.name = nameCocktail
        cocktailsViewModel.cocktail.instructions = receptText
        ingredientsTextfield.remove(at: 0)
        ingredientsText.remove(at: 0)
        cocktailsViewModel.cocktail.ingredientsNames = ingredientsTextfield + ingredientsText
        var measureIngredientTextfield = measureTextfield.map { $0 + " " + nameButtonTextfield.flatMap { $0 } }
        measureIngredientTextfield.remove(at: 0)
        var measureIngredientText = measureText.map { $0 + " " + nameButtonText.flatMap { $0 } }
        measureIngredientText.remove(at: 0)
        cocktailsViewModel.cocktail.ingredientsMeasures = measureIngredientTextfield + measureIngredientText
        cocktailsViewModel.image = image.pngData() ?? Data()
        cocktailsViewModel.cocktail.image = "aaaa"
        cocktailsViewModel.cocktail.alcoholic = "Alcoholic"
        cocktailsViewModel.cocktail.tags = "dddd"
        cocktailsViewModel.cocktail.comments = ["a": "s"]
        return cocktailsViewModel.cocktail
    }
    
    private func uploadData() {
        
        let cocktail = configureCocktail()
        print(cocktail)
        let imageData = cocktailsViewModel.image
        
        DataBaseService.shared.setCocktail(cocktail: cocktail, image: imageData) { result in
            switch result {
            case .success(_):
                showProgressView = false
                dismiss()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//struct AddCocktailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCocktailView(ingredientsViewModel: IngredientsViewModel(allIngredients: [IngredientDB(name: "xxx")]))
//    }
//}
