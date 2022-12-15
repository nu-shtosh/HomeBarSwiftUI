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
            VStack() {
                UserImageView()
                Text("Alex")
                    .font(.title)
                    .foregroundColor(Color("neonOrange"))
                Text("18 age")
                    .font(.title3)
                    .foregroundColor(Color("neonOrange"))
                HStack {
                    Text("Your cocktails:")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
                
                UserButtonsView()
                Spacer()
                HStack {
                    Text("Last viewed cocktails:")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                    Spacer()
                }
               
                LastCocktailView()
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 16, bottom: 0, trailing: 16))
        }
        
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
                .foregroundColor(Color("neonOrange"))
                .font(.title3)
        }
        .frame(width: 180, height: 60)
        .background(Color(red: 70 / 255, green: 70 / 255, blue: 70 / 255))
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
            HStack {
                UserButtonView(text: "Add cocktails", action: {})
                Spacer()
            }
            .padding(.top, 10)
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
                Spacer()
            }
        }
    }
}
