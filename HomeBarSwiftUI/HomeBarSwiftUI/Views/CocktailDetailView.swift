//
//  CocktailDetailView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI

struct CocktailDetailView: View {
    
    var cocktail: CocktailDB
    var profile: UserDB

    @State private var image = Data()
    @Binding var flag: Bool
    @StateObject var profileViewModel: ProfileViewModel
    @StateObject var newCocktailViewModel: NewCocktailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var isFavorite: Bool {
        profile.favoritesCocktails.contains(cocktail.name)
    }
    
    var body: some View {

        ZStack {
            WallpaperView()
            ScrollView(showsIndicators: false) {
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
                    .padding(.top)
                    
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
                            ForEach(0 ..< cocktail.ingredientsNames.count) { index in
                                HStack() {
                                    Text(cocktail.ingredientsNames[index]).foregroundColor(Color("neonOrange"))
                                    Spacer()
                                    Text(cocktail.ingredientsMeasures[index]).foregroundColor(Color("neonBlue"))
                                }
                                if index < (cocktail.ingredientsNames.count - 1) {
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
                                .padding(.horizontal, 4)
                                .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity)
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
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: flag ? addInFavorites : deleteCocktail) {
                        if flag {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                        } else {
                            Image(systemName: "trash")
                        }
                    }
                    .animation(.default, value: isFavorite)
                    .onSubmit {
                        profileViewModel.setProfile()
                        
                    }
                }
            }
            .onAppear {
                if flag {
                    getImage(imageURL: cocktail.image)
                } else {
                    getImageNewCocktail(cocktail.name)
                }
            }
        }
    }
    func deleteCocktail() {
        DataBaseService.shared.deleteNewCocktail(cocktail: cocktail.name)
        newCocktailViewModel.getNewCocktail()
        presentationMode.wrappedValue.dismiss()
    }
    
    func addInFavorites() {
        if !isFavorite {
            profileViewModel.profile.favoritesCocktails.append(cocktail.name)
            uploadData()
        } else {
            if let index =  profileViewModel.profile.favoritesCocktails.firstIndex(of: cocktail.name) {
                profileViewModel.profile.favoritesCocktails.remove(at: index)
                uploadData()
            }
        }
    }

    private func uploadData() {
        let user = profileViewModel.profile
        guard let imageData = profileViewModel.image.jpegData(compressionQuality: 0.1) else {
            return
        }
        DataBaseService.shared.setProfile(user: user, image: imageData) { result  in
            switch result {
            case .success(_):
                print("Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Get Image
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
    
    func getImageNewCocktail(_ id: String) {
        StorageService.shared.downloadCocktailImage(id: id) { result in
            switch result {
            case .success(let data):
               image = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}
