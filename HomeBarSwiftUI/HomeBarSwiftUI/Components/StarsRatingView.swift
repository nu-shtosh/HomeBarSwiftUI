//
//  StarsRatingView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 19.03.2023.
//

import SwiftUI

struct StarsRatingView: View {
    struct ClipShape: Shape {
        let width: Double

        func path(in rect: CGRect) -> Path {
            Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height))
        }
    }

    var rating: Double

    let maxRating: Int = 5


    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Text(Image(systemName: "star"))
                    .foregroundColor(Color("neonBlue"))
                    .aspectRatio(contentMode: .fill)
            }
        }.overlay(
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(0..<maxRating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(Color("neonOrange"))
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .clipShape(
                    ClipShape(width: (reader.size.width / CGFloat(maxRating)) * CGFloat(rating))
                )
            }
        )
    }
}

struct StarsRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarsRatingView(rating: 1.1)
    }
}
