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
        VStack(spacing: 5) {
            Text(cocktail.name)
                .foregroundColor(Color("neonBlue"))
            HStack(spacing: 5) {
                Image(uiImage: UIImage(data: image) ?? UIImage(systemName: "person")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: screen.width * 0.2)
                    .cornerRadius(20)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Favorite: \(cocktail.numberOfRatings)")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                    Text("Rating: \(lround(cocktail.rating))")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                    Text("Type: \(cocktail.alcoholic)")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                }
            }
        }
        .redacted(reason: image.isEmpty ? .placeholder : [])
        .shimmering(active: image.isEmpty)
        
        .padding(5)
        .background(Color(.gray).opacity(0.2))
        .cornerRadius(20)
        
        .frame(width: screen.width * 0.55, height: screen.height * 0.15, alignment: .center)
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
