//
//  NewCocktailCell.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 15.04.2023.
//

import SwiftUI

struct NewCocktailCell: View {
    
    var cocktail: CocktailDB
    @Binding var image: Data
    
    var body: some View {
        VStack(spacing: 10) {
            
            // MARK: - Cocktail Name
            Text(cocktail.name)
                .foregroundColor(Color("neonBlue"))
                .frame(width: 140)
                .font(.system(size: 13))
                .bold()
                .lineLimit(2)
            
            
            HStack(spacing: 6) {
                // MARK: - Cocktail Image
                Image(uiImage: UIImage(data: image) ?? UIImage(named: "pinaColada")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)
                
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    // MARK: - Cocktail Type
                    Text("\(cocktail.alcoholic)")
                        .lineLimit(2)
                        .font(.system(size: 12))
                        .foregroundColor(Color("neonOrange"))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color("neonBlue").opacity(0.3))
                    
                    // MARK: - Cocktail Ingredients Count
                    Text("Ingredients: \(cocktail.ingredientsNames.count)")
                        .font(.system(size: 12))
                        .lineLimit(1)
                        .foregroundColor(Color("neonOrange"))
                        .frame(width: 80)
                }
            }
            .frame(width: 170)
        }
        .frame(width: 180, height: 135)
        .padding(4)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
            colors: [Color("neonBlue"), Color("neonOrange")],
            startPoint: .top,
            endPoint: .bottom
        ).opacity(0.3), lineWidth: 2))
        .background(LinearGradient(colors: [Color("neonBlue"), Color("neonOrange")],
                                   startPoint: .top,
                                   endPoint: .bottom).opacity(0.15))
        .cornerRadius(16)
        
        .redacted(reason: image.isEmpty ? .placeholder : [])
        .shimmering(active: image.isEmpty)
        
        .frame(width: screen.width * 0.5, height: screen.height * 0.18, alignment: .center)
      
        
    }
}
