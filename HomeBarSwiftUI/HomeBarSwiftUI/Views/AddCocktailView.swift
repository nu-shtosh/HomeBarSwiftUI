//
//  AddCocktailView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 23.03.2023.
//

import SwiftUI

struct AddCocktailView: View {
    @State var text = ""
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .foregroundColor(Color("neonOrange"))
                    .frame(width: 100, height: 100)
                Text("Name cocktail")
                    .font(.callout)
                    .bold()
                    .foregroundColor(.gray)
                TextFieldWithImageView(title: "Name cocktail", imageSystemName: "", text: $text)
                HStack {
                    Text("Ingredients")
                        .font(.callout)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "minus")
                            .resizable()
                            .frame(width: 30, height: 3)
                            .foregroundColor(Color("neonOrange"))
                    }
                    .padding(.trailing, 8)

                }
                Text("Recipt")
                    .font(.callout)
                    .bold()
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                TextEditor(text: $text)
                  
                Text(text)
                    
                    
            }
        }
    }
}

struct AddCocktailView_Previews: PreviewProvider {
    static var previews: some View {
        AddCocktailView()
    }
}
