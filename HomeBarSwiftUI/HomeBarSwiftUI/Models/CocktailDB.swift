//
//  CocktailModel.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 12.12.2022.
//
// xx

import Foundation
import FirebaseFirestore

struct CocktailDB {
    let id: String
    let name: String
    let tags: String
    let alcoholic: String
    let instructions: String
    let image: String
    let ingredients: [String: String]
    let rating: Double
    let numberOfRatings: Int
    let sumOfRating: Double
    let userRating: Double
    let likes: Int
    let comments: [String: Any]

    init(id: String,
         name: String,
         tags: String,
         alcoholic: String,
         instructions: String,
         image: String,
         ingredients: [String : String],
         rating: Double,
         numberOfRatings: Int,
         sumOfRating: Double,
         userRating: Double,
         likes: Int,
         comments: [String : Any]) {
        self.id = id
        self.name = name
        self.tags = tags
        self.alcoholic = alcoholic
        self.instructions = instructions
        self.image = image
        self.ingredients = ingredients
        self.rating = rating
        self.numberOfRatings = numberOfRatings
        self.sumOfRating = sumOfRating
        self.userRating = userRating
        self.likes = likes
        self.comments = comments
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let id = data["id"] as? String else { return nil }
        guard let name = data["name"] as? String else { return nil }
        guard let tags = data["tags"] as? String else { return nil }
        guard let alcoholic = data["alcoholic"] as? String else { return nil }
        guard let instructions = data["instructions"] as? String else { return nil }
        guard let image = data["image"] as? String else { return nil }
        guard let ingredients = data["ingredients"] as? [String: String] else { return nil }
        guard let rating = data["rating"] as? Double else { return nil }
        guard let numberOfRatings = data["numberOfRatings"] as? Int else { return nil }
        guard let sumOfRating = data["sumOfRating"] as? Double else { return nil }
        guard let userRating = data["userRating"] as? Double else { return nil }
        guard let likes = data["likes"] as? Int else { return nil }
        guard let comments = data["comments"] as? [String: Any] else { return nil }

        self.id = id
        self.name = name
        self.tags = tags
        self.alcoholic = alcoholic
        self.instructions = instructions
        self.image = image
        self.ingredients = ingredients
        self.rating = rating
        self.numberOfRatings = numberOfRatings
        self.sumOfRating = sumOfRating
        self.userRating = userRating
        self.likes = likes
        self.comments = comments
    }
}
