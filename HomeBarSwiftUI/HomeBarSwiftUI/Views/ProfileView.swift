//
//  ProfileView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 11.12.2022.
//

import SwiftUI

struct ProfileView: View {
    let layout = [GridItem(.adaptive(minimum: screen.height))]
    
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                HStack {
                    UserImageView()
                        .padding(5)
                    VStack(alignment: .leading, spacing: 10) {
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("18 age")
                                .font(.title3)
                                .foregroundColor(Color("neonOrange"))
                        }
                        .padding(.leading, 16)
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
                .padding(.leading, 5)
                .padding(.top, 5)
                HStack {
                    UserButtonsView()
                    
                }
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
                .padding(.leading, 5)
                LastCocktailView()
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16))
        }
        .navigationTitle(Text("User name"))
        .toolbar {
            Button(action: {}) {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(Color("neonOrange"))
            }
            
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
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
        }
        .frame(width: 180, height: 50)
        .background(Color("neonOrange"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct UserButtonsView: View {
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
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(CocktailsViewModel.shared.drinks, id: \.id) { item in
                    NavigationLink {
                        CocktailDetailView(cocktail: item)
                            .navigationTitle(item.name)
                    } label: {
                        CocktailCellView(cocktail: item)
                    }
                }.foregroundColor(Color("neonBlue"))
                    .padding(.leading, -16)
            }
            
        }
    }
}
