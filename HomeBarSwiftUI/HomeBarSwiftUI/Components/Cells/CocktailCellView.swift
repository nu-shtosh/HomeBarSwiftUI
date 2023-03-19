//
//  CocktailCellView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 14.12.2022.
//

import SwiftUI
import Shimmer

struct CocktailCellView: View {
    var cocktail: CocktailDB
    @State var image = Data()
    
    var body: some View {
        VStack(spacing: 10) {
            Text(cocktail.name)
                .foregroundColor(Color("neonBlue"))
                .frame(width: 140)
                .font(.system(size: 13))
                .lineLimit(2)
            HStack(spacing: 6) {
                Image(uiImage: UIImage(data: image) ?? UIImage(named: "pinaColada")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 6) {

                    Text("Favorite: \(cocktail.numberOfRatings)")
                        .font(.system(size: 12))
                        .foregroundColor(Color("neonOrange"))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color("neonBlue").opacity(0.3))
                    Text("Rating: \(lround(cocktail.rating))")
                        .font(.system(size: 12))
                        .foregroundColor(Color("neonOrange"))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color("neonBlue").opacity(0.3))
                    Text("\(cocktail.alcoholic)")
                        .lineLimit(2)
                        .font(.system(size: 12))
                        .foregroundColor(Color("neonOrange"))
                    
                }
            }
            .frame(width: 150)
        }
        .frame(width: 170, height: 135)
        .padding(2)
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

        .frame(width: screen.width * 0.5, height: screen.height * 0.2, alignment: .center)

        
        .onAppear {
            getImage(imageURL: cocktail.image)
        }

    }

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
}


//struct CocktailImage: View {
//    let imageData: Data
//    let imageSize: CGSize
//    let cornerRadius: CGFloat
//    let shadowIsOn: Bool
//
//    var body: some View {
//        getImage(from: imageData)
//            .resizable()
//            .frame(width: imageSize.width, height: imageSize.height)
//            .cornerRadius(cornerRadius)
//            .shadow(radius: shadowIsOn ? 10 : 0)
//    }
//
//    private func getImage(from data: Data) -> Image {
//        guard let image = UIImage(data: data) else {
//            return Image(systemName: "xmark.shield")
//        }
//        return Image(uiImage: image)
//    }
//}

struct CocktailCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WallpaperView()
            CocktailCellView(cocktail: CocktailDB(name: "White Russian", tags: "Cocktail", alcoholic: "Alcoholic", instructions: "shake in glass", image: "whiteRussian", ingredients: ["vodka":"50", "crema": "50", "kaluha": "50"], rating: 5.0, numberOfRatings: 5, sumOfRating: 5.0, userRating: 5.0, likes: 13, comments: ["user": "ilia", "title": "good drink", "text": "my favorite"]))
        }
    }
}
