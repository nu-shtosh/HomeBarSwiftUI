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
    private let measures = MeasureDataStore.shared.measures
    @State private var showImagePicker = false
    @State private var showProgressView = false
    @State private var showAlert = false
    @State var image = UIImage(named: "pinaColada")!
    @FocusState private var isInputActive: Bool
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ZStack {
                // MARK: - Wallpaper View
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
                                        image != UIImage(named: "pinaColada")
                                        ? screen.width - 32
                                        : 200
                                    },
                                height:
                                    withAnimation{
                                        image != UIImage(named: "pinaColada")
                                        ? screen.width - 32
                                        : 200
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
                        // MARK: - cocktail Name
                        Text("Name cocktail")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    // MARK: - cocktail Name textfield
                    HStack {
                        DefaultTextFieldView(
                            title: "Name cocktail",
                            text: $nameCocktail,
                            sizeWidth: nil,
                            sizeHeight: 40
                        )
                        .focused($isInputActive)
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
                    HStack {
                        // MARK: - Ingredient Name
                        Text("Ingredients")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                        Spacer()
                        // MARK: - Button add Ingredient
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
                    // MARK: - Ingredients Textfield List
                    VStack {
                        if ingredientsTextfield.count == 1 && ingredientsText.count == 1 {
                            withAnimation {
                                Text("Add ingredient")
                                    .foregroundColor(Color("neonOrange"))
                                    .frame(width: screen.width - 64)
                            }
                        }
                        ForEach(ingredientsTextfield.indices, id: \.self) { index in
                            if index > 0 {
                                HStack {
                                    // MARK: - name Ingredients Textfield
                                    DefaultTextFieldView(
                                        title: "",
                                        text: $ingredientsTextfield[index],
                                        sizeWidth: nil,
                                        sizeHeight: 40
                                    )
                                    .focused($isInputActive)
                                   
                                    Spacer()
                                    // MARK: - name measure Textfield
                                    DefaultTextFieldView(
                                        title: "",
                                        text: $measureTextfield[index],
                                        sizeWidth: 70,
                                        sizeHeight: 40
                                    )
                                    .focused($isInputActive)
                                    // MARK: -  measure button
                                    Menu(nameButtonTextfield[index]) {
                                        ForEach(measures, id: \.self) { measure in
                                            Button(measure) {
                                                nameButtonTextfield[index] = measure
                                            }
                                        }
                                    }
                                    .foregroundColor(Color("neonBlue"))
                                    .frame(width: 75)
                                    .padding(.trailing, 5)
                                    // MARK: - Button deleted Ingredient
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
                                   
                                }
                            }
                        }
                        // MARK: - Ingredients Text & Textfield List
                        ForEach(ingredientsText.indices, id: \.self) { index in
                            if index > 0 {
                                HStack {
                                    // MARK: - name Ingredients Text
                                    Text(ingredientsText[index])
                                        
                                        .foregroundColor(Color("neonOrange"))
                                    Spacer()
                                    // MARK: - name measure Textfield
                                    DefaultTextFieldView(
                                        title: "",
                                        text: $measureText[index],
                                        sizeWidth: 70,
                                        sizeHeight: 40
                                    )
                                    .focused($isInputActive)
                                    // MARK: -  measure button
                                    Menu(nameButtonText[index]) {
                                        ForEach(measures, id: \.self) { measure in
                                            Button(measure) {
                                                nameButtonText[index] = measure
                                            }
                                        }
                                    }
                                    .foregroundColor(Color("neonBlue"))
                                    .frame(width: 75)
                                    .padding(.trailing, 5)
                                    // MARK: - Button deleted Ingredient
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
                    
                                }
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
                    // MARK: - name Recipe
                    HStack {
                        Text("Recipe")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    // MARK: - Recept TextEditor
                    HStack {
                        TextField("Recipe", text: $receptText, axis: .vertical)
                            .textFieldStyle(GradientTextFieldBackground())
                            .foregroundColor(.black)
                            .lineLimit(1...200)
                            .focused($isInputActive)
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
                    // MARK: - Button save cocktail
                    OrangeButtonView(
                        action: {
                        showProgressView = true
                        saveNewCocktail()
                    },
                        title: "Save"
                    )
                    .padding()
                }
                .padding()
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
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Not all fields are filled!"),
                    message: Text("Please complete all fields and try again.🍹"),
                    dismissButton: .default(Text("Ok"))
                )
            }
            .onTapGesture {
                isInputActive = false
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
        nameButtonTextfield.append("measure")
    }
    
    private func appendText() {
        measureText.append("")
        nameButtonText.append("measure")
    }
    
    private func uploadData() {
        let cocktail = cocktailsViewModel.configureCocktail(
            nameCocktail,
            receptText,
            &ingredientsTextfield,
            &ingredientsText,
            measureTextfield,
            measureText,
            nameButtonTextfield,
            nameButtonText
        )
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
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

    private func saveNewCocktail() {
        if ingredientsTextfield.count > 1 && ingredientsText.count > 1 {
            if nameCocktail.isEmpty || receptText.isEmpty || ingredientsTextfield[1].isEmpty || measureTextfield[1].isEmpty || measureText[1].isEmpty || nameButtonTextfield.contains("measure") || nameButtonText.contains("measure") {
                showProgressView = false
                showAlert.toggle()
            } else {
                uploadData()
            }
        } else if ingredientsTextfield.count == 1 && ingredientsText.count > 1 {
            if nameCocktail.isEmpty || receptText.isEmpty ||  measureText[1].isEmpty ||  nameButtonText.contains("measure") {
                showProgressView = false
                showAlert.toggle()
            } else {
                uploadData()
            }
        } else if ingredientsTextfield.count > 1 && ingredientsText.count == 1 {
            if nameCocktail.isEmpty || receptText.isEmpty || ingredientsTextfield[1].isEmpty || measureTextfield[1].isEmpty || nameButtonTextfield.contains("measure") {
                showProgressView = false
                showAlert.toggle()
            } else {
                uploadData()
            }
        } else {
            showProgressView = false
            showAlert.toggle()
        }
    }
}

struct AddCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCocktailView(ingredientsViewModel: IngredientsViewModel(allIngredients: [IngredientDB(name: "xxx")]), cocktailsViewModel: CocktailsViewModel(
            allCocktails: [CocktailDB(
                name: "",
                tags: "",
                alcoholic: "",
                instructions: "",
                image: "",
                ingredientsNames: [""],
                ingredientsMeasures: [""],
                rating: 0,
                numberOfRatings: 0,
                sumOfRating: 0,
                userRating: 0,
                likes: 0,
                comments: ["" : ""]
            )], cocktail: CocktailDB(
                name: "",
                tags: "",
                alcoholic: "",
                instructions: "",
                image: "",
                ingredientsNames: [""],
                ingredientsMeasures: [""],
                rating: 0,
                numberOfRatings: 0,
                sumOfRating: 0,
                userRating: 0,
                likes: 0,
                comments: ["" : ""]
            ),
            image: Data()
        ))
    }
}
