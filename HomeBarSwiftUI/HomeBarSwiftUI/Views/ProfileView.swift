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
                HStack {
                    UserImageView(image: $profileViewModel.image)
                        .padding(5)
                    UserInfoView(age: $profileViewModel.profile.age)
                    Spacer()
                }
                .padding(5)
                .background(Color(.gray).opacity(0.2))
                .cornerRadius(20)
                HStack {
                    Text("Your cocktails:")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(EdgeInsets(top: 5, leading: 11, bottom: -5, trailing: 0))
                HStack {
                    UserButtonStackView()
                }
                .padding(5)
                .background(Color(.gray).opacity(0.2))
                .cornerRadius(20)
                Spacer()
                HStack {
                    Text("Last viewed cocktails:")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(EdgeInsets(top: 5, leading: 11, bottom: -5, trailing: 0))
                LastCocktailView(cocktailViewModel: cocktailViewModel)
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16))
        }
        .onAppear {
            profileViewModel.getProfile()
        }
        .navigationTitle(Text(profileViewModel.profile.fullname))
        .toolbar {
            NavigationLink {
                SettingUserView(profileViewModel: profileViewModel)
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(Color("neonOrange"))
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(profileViewModel: ProfileViewModel(profile: UserDB(
//            id: "1",
//            name: "",
//            surname: "",
//            age: ""
//        )))
//    }
//}

struct UserButtonView: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(Color.white)
                .font(.title3)
        }
        .frame(width: 180, height: 50)
        .background(Color("neonOrange"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct UserButtonStackView: View {
    var body: some View {
        VStack {
            HStack {
                UserButtonView(text: "My cocktails", action: {})
                Spacer()
                    .padding(.trailing, 5)
                UserButtonView(text: "Favorites cocktails", action: {})
            }
            .padding(5)
            HStack {
                UserButtonView(text: "Add cocktails", action: {})
                Spacer()
            }
            .padding(5)
        }
    }
}

struct LastCocktailView: View {
    @StateObject var cocktailViewModel: CocktailsViewModel
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(cocktailViewModel.cocktail, id: \.name) { item in
                    NavigationLink {
                        CocktailDetailView(cocktail: item)
                            .navigationTitle(item.name)
                    } label: {
                        CocktailCellView(cocktail: item)
                    }
                }.foregroundColor(Color("neonBlue"))
                    .padding(.leading, -5)
            }
        }
    }
}

struct UserInfoView: View {
    @Binding var age: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Age: \(age)")
                .font(.title3)
                .foregroundColor(Color("neonOrange"))
            Text("Favorites: 16")
                .font(.system(size: 18))
                .foregroundColor(Color("neonOrange"))
            Text("Your like: 19")
                .font(.system(size: 18))
                .foregroundColor(Color("neonOrange"))
            Text("More info...")
                .font(.system(size: 18))
                .foregroundColor(Color("neonOrange"))
        }
        .offset(x: 50)
    }
}
