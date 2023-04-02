//
//  ProfileView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var profileViewModel: ProfileViewModel
    @StateObject var cocktailViewModel: CocktailsViewModel
    
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                // MARK: User info
                HStack {
                    UserImageView(image: $profileViewModel.image)
                        .padding()
                    UserInfoView(profileViewModel: profileViewModel,
                                 age: $profileViewModel.profile.age)
                    
                    Spacer()
                }
                
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                    colors: [Color("neonBlue"), Color("neonOrange")],
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.3), lineWidth: 2))
                .background(LinearGradient(colors: [Color("neonBlue"),
                                                    Color("neonOrange")],
                                           startPoint: .top,
                                           endPoint: .bottom).opacity(0.15))
                .padding()
                // MARK: Buttons
                HStack {
                    Text("Your cocktails:")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(
                            top: -8,
                            leading: 16,
                            bottom: -8,
                            trailing: 0
                        ))
                    Spacer()
                }
                
                HStack {
                    UserButtonStackView(cocktailViewModel: cocktailViewModel,
                                        profileViewModel: profileViewModel)
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                    colors: [Color("neonBlue"), Color("neonOrange")],
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.3), lineWidth: 2))
                .background(LinearGradient(colors: [Color("neonBlue"),
                                                    Color("neonOrange")],
                                           startPoint: .top,
                                           endPoint: .bottom).opacity(0.15))
                .padding()
                
                VStack {
                    // MARK: Last cocktails
                    HStack {
                        Text("Last viewed cocktails:")
                            .font(.callout)
                            .bold()
                            .foregroundColor(.gray)
                            .padding(EdgeInsets(
                                top: -8,
                                leading: 16,
                                bottom: -8,
                                trailing: 0
                            ))
                        Spacer()
                    }
                    
                    LastCocktailView(cocktailViewModel: cocktailViewModel,
                                     profileViewModel: profileViewModel)
                }
            }
            .padding(EdgeInsets(top: 6, leading: 6, bottom: 7, trailing: 6))
        }
        .onAppear {
            profileViewModel.getProfile()
            cocktailViewModel.getCocktail()
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(Text(profileViewModel.profile.fullname))
        .toolbar {

            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingUserView(profileViewModel: profileViewModel)
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(Color("neonOrange"))
                }
            }
        }
    }
}

struct UserButtonView: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(Color.white)
                .font(.title3)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
        .background(Color("neonOrange"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct UserButtonStackView: View {

    @StateObject var cocktailViewModel: CocktailsViewModel
    @StateObject var profileViewModel: ProfileViewModel

    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    FavoritesCocktailsView(cocktailViewModel: cocktailViewModel,
                                           profileViewModel: profileViewModel)
                } label: {
                    Text("My favorites")
                        .foregroundColor(Color.white)
                        .font(.title3)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .background(Color("neonOrange"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                UserButtonView(text: "My cocktails", action: {})
                Spacer()
            }
            .padding(.bottom)
            HStack {
                UserButtonView(text: "Add cocktail", action: {})
                Spacer()
            }
            
        }
    }
}

struct LastCocktailView: View {
    @StateObject var cocktailViewModel: CocktailsViewModel
    @StateObject var profileViewModel: ProfileViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(cocktailViewModel.allCocktails), id: \.name) { item in
                    NavigationLink {
                        CocktailDetailView(cocktail: item, profile: profileViewModel.profile, profileViewModel: profileViewModel)
                            .navigationTitle(item.name)
                    } label: {
                        CocktailCellView(cocktail: item, image: cocktailViewModel.image)
                    }
                }.foregroundColor(Color("neonBlue"))
                    .padding(.leading, -5)
            }
        }
    }
}

struct UserInfoView: View {
    @StateObject var profileViewModel: ProfileViewModel

    @Binding var age: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Age: \(age)")
                .font(.title3)
                .foregroundColor(Color("neonOrange"))
            Text("Favorites: \(profileViewModel.profile.favoritesCocktails.count)")
                .font(.system(size: 18))
                .foregroundColor(Color("neonOrange"))
            Text("Your like: 19")
                .font(.system(size: 18))
                .foregroundColor(Color("neonOrange"))
            Text("More info...")
                .font(.system(size: 18))
                .foregroundColor(Color("neonOrange"))
        }
    }
}


