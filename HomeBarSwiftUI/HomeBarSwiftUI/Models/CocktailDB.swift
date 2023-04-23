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
    var name: String
    var tags: String
    var alcoholic: String
    var instructions: String
    var image: String
    var ingredientsNames: [String]
    var ingredientsMeasures: [String]
    var rating: Double
    var numberOfRatings: Int
    var sumOfRating: Double
    var userRating: Double
    var likes: Int
    var comments: [String: Any]
    var idUser: String

    var representation: [String: Any] {
        var representation = [String: Any]()
        representation["name"] = self.name
        representation["tags"] = self.tags
        representation["alcoholic"] = self.alcoholic
        representation["instructions"] = self.instructions
        representation["image"] = self.image
        representation["ingredientsNames"] = self.ingredientsNames
        representation["ingredientsMeasures"] = self.ingredientsMeasures
        representation["rating"] = self.rating
        representation["numberOfRatings"] = self.numberOfRatings
        representation["sumOfRating"] = self.sumOfRating
        representation["userRating"] = self.userRating
        representation["like"] = self.likes
        representation["comments"] = self.comments
        representation["idUser"] = self.idUser
        return representation
    }
    
    init(name: String,
         tags: String,
         alcoholic: String,
         instructions: String,
         image: String,
         ingredientsNames: [String],
         ingredientsMeasures: [String],
         rating: Double,
         numberOfRatings: Int,
         sumOfRating: Double,
         userRating: Double,
         likes: Int,
         comments: [String : Any],
         idUser: String
    ) {
        self.name = name
        self.tags = tags
        self.alcoholic = alcoholic
        self.instructions = instructions
        self.image = image
        self.ingredientsNames = ingredientsNames
        self.ingredientsMeasures = ingredientsMeasures
        self.rating = rating
        self.numberOfRatings = numberOfRatings
        self.sumOfRating = sumOfRating
        self.userRating = userRating
        self.likes = likes
        self.comments = comments
        self.idUser = idUser
    }


    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let name = data["name"] as? String else { return nil }
        guard let tags = data["tags"] as? String else { return nil }
        guard let alcoholic = data["alcoholic"] as? String else { return nil }
        guard let instructions = data["instructions"] as? String else { return nil }
        guard let image = data["image"] as? String else { return nil }
        guard let ingredientsNames = data["ingredientsNames"] as? [String] else { return nil }
        guard let ingredientsMeasures = data["ingredientsMeasures"] as? [String] else { return nil }
        guard let rating = data["rating"] as? Double else { return nil }
        guard let numberOfRatings = data["numberOfRatings"] as? Int else { return nil }
        guard let sumOfRating = data["sumOfRating"] as? Double else { return nil }
        guard let userRating = data["userRating"] as? Double else { return nil }
        guard let likes = data["like"] as? Int else { return nil }
        guard let comments = data["comments"] as? [String: Any] else { return nil }
        guard let idUser = data["idUser"] as? String else { return nil }
        
        self.name = name
        self.tags = tags
        self.alcoholic = alcoholic
        self.instructions = instructions
        self.image = image
        self.ingredientsNames = ingredientsNames
        self.ingredientsMeasures = ingredientsMeasures
        self.rating = rating
        self.numberOfRatings = numberOfRatings
        self.sumOfRating = sumOfRating
        self.userRating = userRating
        self.likes = likes
        self.comments = comments
        self.idUser = idUser 
    }
}
